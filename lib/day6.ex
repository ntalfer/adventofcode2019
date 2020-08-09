defmodule Day6 do
  def part1(file) do
    graph = build_graph(file)

    vertices = :digraph.vertices(graph) -- ["COM"]

    vertices
    |> Enum.reduce(0, fn(v, acc) ->
        acc + Enum.count(:digraph.get_short_path(graph, "COM", v)) - 1
    end)
  end

  def part2(file) do
    graph = build_graph(file)
    path = :digraph.get_short_path(graph, "YOU", "SAN")
    IO.inspect path
    Enum.count(path) - 3
  end

  defp build_graph(file) do
    graph = :digraph.new()

    file
    |> File.stream!()
    |> Stream.each(fn line ->
      [vertex1, vertex2] = String.split(String.trim_trailing(line), ")")
      :digraph.add_vertex(graph, vertex1)
      :digraph.add_vertex(graph, vertex2)
      :digraph.add_edge(graph, vertex1, vertex2)
      :digraph.add_edge(graph, vertex2, vertex1)
    end)
    |> Stream.run()

    graph
  end
end
