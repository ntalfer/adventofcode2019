defmodule Day1Test do
  use ExUnit.Case

  test "part1 examples" do
    assert Day1.part1_fuel(2) == 0
    assert Day1.part1_fuel(12) == 2
    assert Day1.part1_fuel(14) == 2
    assert Day1.part1_fuel(1969) == 654
    assert Day1.part1_fuel(100_756) == 33583
  end

  test "part1 challenge" do
    assert Day1.part1("test/day1_input.txt") == 3_464_735
  end

  test "part2 examples" do
    assert Day1.part2_fuel(14) == 2
    assert Day1.part2_fuel(1969) == 966
    assert Day1.part2_fuel(100_756) == 50346
  end

  test "part2 challenge" do
    assert Day1.part2("test/day1_input.txt") == 5_194_211
  end
end
