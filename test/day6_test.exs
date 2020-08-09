defmodule Day6Test do
    use ExUnit.Case

    test "part1" do
        assert Day6.part1("test/day6_input.txt") == 294191
    end

    test "part2" do
        assert Day6.part2("test/day6_input.txt") == 424
    end
end