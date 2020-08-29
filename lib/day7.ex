defmodule Day7 do
  def part1(file) do
    program =
      file
      |> File.read!()
      |> String.trim_trailing()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    part1_by_program(program)
  end

  def part1_by_program(program) do
    IO.inspect program

    settings =
      for a <- 0..4,
          b <- 0..4,
          c <- 0..4,
          d <- 0..4,
          e <- 0..4,
          a != b,
          a != c,
          a != d,
          a != e,
          b != c,
          b != d,
          b != e,
          c != d,
          c != e,
          d != e do
        [a, b, c, d, e]
      end

      IO.inspect settings

    settings
    |> Enum.map(fn(setting) ->
        {setting, calculate_output(setting, program)}
    end)
    |> List.keysort(1)
    |> List.last()
    |> case do
        {_, o} -> o
    end
  end

  defp calculate_output([n1, n2, n3, n4, n5], program) do
    o_0 = 0
    o_1 = Day5.run(program, [n1, o_0])
    o_2 = Day5.run(program, [n2, o_1])
    o_3 = Day5.run(program, [n3, o_2])
    o_4 = Day5.run(program, [n4, o_3])
    o_5 = Day5.run(program, [n5, o_4])
    o_5
  end
end

