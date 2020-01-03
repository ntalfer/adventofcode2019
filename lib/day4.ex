defmodule Day4 do
  def part1(min, max) do
    part1(min, max, 0)
  end

  def part1(curr, max, count) when curr <= max do
    if increasing_nb(curr) and two_same_adjacent(curr) do
      part1(curr + 1, max, count + 1)
    else
      part1(curr + 1, max, count)
    end
  end

  def part1(_curr, _max, count), do: count

  def part2(min, max) do
    part2(min, max, 0)
  end

  def part2(curr, max, count) when curr <= max do
    if increasing_nb(curr) and two_same_adjacent_p2(curr) do
      part2(curr + 1, max, count + 1)
    else
      part2(curr + 1, max, count)
    end
  end

  def part2(_curr, _max, count), do: count  

  defp increasing_nb(n) when is_integer(n) do
    increasing_nb("#{n}")
  end

  defp increasing_nb(<<a, b, c, d, e, f>>) do
    a <= b and b <= c and c <= d and d <= e and e <= f
  end

  defp two_same_adjacent(n) when is_integer(n) do
    two_same_adjacent("#{n}")
  end

  defp two_same_adjacent(<<a, b, c, d, e, f>>) do
    a == b or b == c or c == d or d == e or e == f
  end

  defp two_same_adjacent_p2(n) when is_integer(n) do
    two_same_adjacent_p2("#{n}")
  end

  defp two_same_adjacent_p2(<<a, b, c, d, e, f>>) do
    (a == b and b != c ) or 
    (b == c and a != b and c != d) or
    (c == d and c != b and d != e) or
    (d == e and d != c and e != f) or
    (e == f and d != e)
  end
end
