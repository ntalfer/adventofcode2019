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

  def compute(program, noun, verb) do
    [n0, _n1, _n2 | rest] = program
    new_program = [n0, noun, verb | rest]
    [new_n0 | _] = part1_final_state(new_program)
    new_n0
  end

  def part1(program) do
    compute(program, 12, 2)
  end

  def part2(program, output) do
    part2(program, output, 0, 0)
  end

  def part2(program, output, noun, verb) do
    case compute(program, noun, verb) do
      ^output ->
        100 * noun + verb

      _ when verb < 99 ->
        part2(program, output, noun, verb + 1)

      _ when noun < 99 and verb == 99 ->
        part2(program, output, noun + 1, 0)

      _ when noun < 99 ->
        part2(program, output, noun + 1, 0)

      _ ->
        :not_found
    end
  end
end
