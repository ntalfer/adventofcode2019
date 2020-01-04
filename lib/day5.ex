defmodule Day5 do
  def run(program, input) do
    run(program, 0, input, nil)
  end

  def run(program, index, input, output) do
    %{opcode: code, mode1: mode1, mode2: mode2, mode3: mode3} =
      parse_instruction(Enum.at(program, index))

    #IO.inspect(binding())

    case code do
      99 ->
        output

      code when code == 1 or code == 2 ->
        arg1 =
          case mode1 do
            0 -> Enum.at(program, Enum.at(program, index + 1))
            1 -> Enum.at(program, index + 1)
          end

        arg2 =
          case mode2 do
            0 -> Enum.at(program, Enum.at(program, index + 2))
            1 -> Enum.at(program, index + 2)
          end

        val =
          case code do
            1 -> arg1 + arg2
            2 -> arg1 * arg2
          end

        pos =
          case mode3 do
            0 -> Enum.at(program, index + 3)
            1 -> index + 3
          end

        new_program = store(program, pos, val)
        run(new_program, index + 4, input, output)

      3 ->
        # input
        pos = Enum.at(program, index + 1)
        new_program = store(program, pos, input)
        run(new_program, index + 2, input, output)

      4 ->
        # output
        output = Enum.at(program, Enum.at(program, index + 1))
        run(program, index + 2, input, output)

      5 ->
        param1 =
          case mode1 do
            0 -> Enum.at(program, Enum.at(program, index + 1))
            1 -> Enum.at(program, index + 1)
          end

        param2 =
          case mode2 do
            0 -> Enum.at(program, Enum.at(program, index + 2))
            1 -> Enum.at(program, index + 2)
          end

        case param1 do
          0 ->
            run(program, index + 3, input, output)

          _ ->
            new_index = param2
            run(program, new_index, input, output)
        end

      6 ->
        param1 =
          case mode1 do
            0 -> Enum.at(program, Enum.at(program, index + 1))
            1 -> Enum.at(program, index + 1)
          end

        param2 =
          case mode2 do
            0 -> Enum.at(program, Enum.at(program, index + 2))
            1 -> Enum.at(program, index + 2)
          end

        case param1 do
          0 ->
            new_index = param2
            run(program, new_index, input, output)

          _ ->
            run(program, index + 3, input, output)
        end

      7 ->
        param1 =
          case mode1 do
            0 -> Enum.at(program, Enum.at(program, index + 1))
            1 -> Enum.at(program, index + 1)
          end

        param2 =
          case mode2 do
            0 -> Enum.at(program, Enum.at(program, index + 2))
            1 -> Enum.at(program, index + 2)
          end

        param3 = Enum.at(program, index + 3)

        if param1 < param2 do
          new_program = store(program, param3, 1)
          run(new_program, index + 4, input, output)
        else
          new_program = store(program, param3, 0)
          run(new_program, index + 4, input, output)
        end

      8 ->
        param1 =
          case mode1 do
            0 -> Enum.at(program, Enum.at(program, index + 1))
            1 -> Enum.at(program, index + 1)
          end

        param2 =
          case mode2 do
            0 -> Enum.at(program, Enum.at(program, index + 2))
            1 -> Enum.at(program, index + 2)
          end

        param3 = Enum.at(program, index + 3)

        if param1 == param2 do
          new_program = store(program, param3, 1)
          run(new_program, index + 4, input, output)
        else
          new_program = store(program, param3, 0)
          run(new_program, index + 4, input, output)
        end
    end
  end

  defp store(program, pos, value) do
    {p1, p2} = Enum.split(program, pos)
    [_ | p3] = p2
    p1 ++ [value] ++ p3
  end

  # defp param(program, index, 0) do
  #   Enum.at(program, Enum.at(program, index))
  # end

  # defp param(program, index, 1) do
  #   Enum.at(program, index)
  # end

  def parse_instruction(n) do
    case "#{n}" do
      <<mode1, opcode::16>> ->
        %{
          opcode: String.to_integer(<<opcode::16>>),
          mode1: String.to_integer(<<mode1>>),
          mode2: 0,
          mode3: 0
        }

      <<mode2, mode1, opcode::16>> ->
        %{
          opcode: String.to_integer(<<opcode::16>>),
          mode1: String.to_integer(<<mode1>>),
          mode2: String.to_integer(<<mode2>>),
          mode3: 0
        }

      <<mode3, mode2, mode1, opcode::16>> ->
        %{
          opcode: String.to_integer(<<opcode::16>>),
          mode1: String.to_integer(<<mode1>>),
          mode2: String.to_integer(<<mode2>>),
          mode3: String.to_integer(<<mode3>>)
        }

      _ ->
        %{
          opcode: n,
          mode1: 0,
          mode2: 0,
          mode3: 0
        }
    end
  end
end
