defmodule Day02.Parser do
  def parse_game("Game " <> rest) do
    parts = rest |> String.split(": ")
    id = Enum.at(parts, 0) |> Integer.parse() |> elem(0)
    turns = Enum.at(parts, 1)
    {id, parse_turns(turns)}
  end

  defp parse_turns(turns) do
    turns
    |> String.split("; ", trim: true)
    |> Enum.map(&parse_turn/1)
  end

  defp parse_turn(turn) do
    turn
    |> String.split(", ", trim: true)
    |> Enum.map(&String.reverse/1)
    |> Enum.map(&parse_amount/1)
    |> Enum.into(%{})
  end

  defp parse_amount("der " <> amount) do
    amount = amount |> String.reverse() |> Integer.parse() |> elem(0)
    {:red, amount}
  end

  defp parse_amount("neerg " <> amount) do
    amount = amount |> String.reverse() |> Integer.parse() |> elem(0)
    {:green, amount}
  end

  defp parse_amount("eulb " <> amount) do
    amount = amount |> String.reverse() |> Integer.parse() |> elem(0)
    {:blue, amount}
  end
end
