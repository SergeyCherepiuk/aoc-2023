defmodule Day02 do
  alias Day02.Calculator
  alias Day02.Parser

  def part1(colors) do
    File.read!("lib/day_02/part1.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&Parser.parse_game/1)
    |> Map.new(fn {id, turns} -> {id, Calculator.max(turns)} end)
    |> Map.filter(fn {k, v} -> filter_lower({k, v}, colors) end)
    |> Map.keys()
    |> Enum.sum()
    |> IO.inspect()
  end

  defp filter_lower({_, turns}, colors) do
    Map.get(turns, :red) <= Map.get(colors, :red) and
      Map.get(turns, :green) <= Map.get(colors, :green) and
      Map.get(turns, :blue) <= Map.get(colors, :blue)
  end
end
