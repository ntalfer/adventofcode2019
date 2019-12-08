defmodule Day2 do
  def part1_final_state(program) do
    part1_final_state(program, 0)
  end

  def part1_final_state(program, index) do
    code = Enum.at(program, index)

    case code do
      99 ->
        program

      _ ->
        arg1 = Enum.at(program, Enum.at(program, index + 1))
        arg2 = Enum.at(program, Enum.at(program, index + 2))

        val =
          case code do
            1 -> arg1 + arg2
            2 -> arg1 * arg2
          end

        pos = Enum.at(program, index + 3)
        {p1, p2} = Enum.split(program, pos)
        [_ | p3] = p2
        new_program = p1 ++ [val] ++ p3
        part1_final_state(new_program, index + 4)
    end
  end

  def part1(program) do
    [n0, _n1, _n2 | rest] = program
    new_program = [n0, 12, 2 | rest]
    [new_n0 | _] = part1_final_state(new_program)
    new_n0
  end
end
