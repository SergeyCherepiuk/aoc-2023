defmodule Day1 do
  require Unicode.Guards
  alias Unicode.Guards

  def solution() do
    File.read!("lib/day_01/data.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> filter_digits_and_newline(line) end)
    |> Enum.map(fn digits -> <<List.first(digits)>> <> <<List.last(digits)>> end)
    |> Enum.map(fn digits -> {n, _} = Integer.parse(digits, 10); n end)
    |> Enum.sum()
    |> IO.inspect()
  end

  defp filter_digits_and_newline(line) do
    line
    |> String.to_charlist()
    |> Enum.filter(fn char -> Guards.is_digit(char) end)
  end
end

