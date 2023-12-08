defmodule Day01 do
  require Unicode.Guards
  alias Unicode.Guards

  def part1() do
    File.read!("lib/day_01/part1.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&filter_digits/1)
    |> Enum.map(&first_and_last/1)
    |> Enum.map(&string_to_int/1)
    |> Enum.sum()
    |> IO.inspect()
  end

  def part2() do
    File.read!("lib/day_01/part2.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&replace_spelt_numbers/1)
    |> Enum.map(&filter_digits/1)
    |> Enum.map(&first_and_last/1)
    |> Enum.map(&string_to_int/1)
    |> Enum.sum()
    |> IO.inspect()
  end

  defp filter_digits(line) do
    line
    |> String.to_charlist()
    |> Enum.filter(fn char -> Guards.is_digit(char) end)
  end

  defp first_and_last(digits) do
    <<List.first(digits)>> <> <<List.last(digits)>>
  end

  defp string_to_int(string) do
    elem(Integer.parse(string, 10), 0)
  end

  # Masterpiece by mexicat (https://github.com/plungingChode/aoc-2023/blob/master/day1/day1.ex)
  defp replace_spelt_numbers("one" <> rest), do: "o1" <> replace_spelt_numbers("e" <> rest)
  defp replace_spelt_numbers("two" <> rest), do: "t2" <> replace_spelt_numbers("o" <> rest)
  defp replace_spelt_numbers("three" <> rest), do: "t3" <> replace_spelt_numbers("e" <> rest)
  defp replace_spelt_numbers("four" <> rest), do: "f4" <> replace_spelt_numbers("r" <> rest)
  defp replace_spelt_numbers("five" <> rest), do: "f5" <> replace_spelt_numbers("e" <> rest)
  defp replace_spelt_numbers("six" <> rest), do: "s6" <> replace_spelt_numbers("x" <> rest)
  defp replace_spelt_numbers("seven" <> rest), do: "s7" <> replace_spelt_numbers("n" <> rest)
  defp replace_spelt_numbers("eight" <> rest), do: "e8" <> replace_spelt_numbers("t" <> rest)
  defp replace_spelt_numbers("nine" <> rest), do: "n9" <> replace_spelt_numbers("e" <> rest)
  defp replace_spelt_numbers(<<char, rest::binary>>), do: <<char>> <> replace_spelt_numbers(rest)
  defp replace_spelt_numbers(""), do: ""
end
