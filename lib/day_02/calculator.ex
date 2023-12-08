defmodule Day02.Calculator do
  def max(turns) do
    Enum.reduce(turns, %{}, fn turn, acc ->
      Map.merge(turn, acc, fn _, value1, value2 ->
        if value1 > value2, do: value1, else: value2
      end)
    end)
  end
end
