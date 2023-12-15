defmodule Day05 do
  def part1 do
    parse_mappings()
  end

  defp parse_mappings() do
    input =
      File.read!("lib/day_05/part1.txt")
      |> String.split("\n\n", trim: true)
      |> Enum.map(fn map -> String.split(map, "\n", trim: true) end)

    seeds =
      input
      |> Enum.at(0)
      |> Enum.at(0)
      |> String.trim_leading("seeds: ")
      |> parse_numbers()

    mappings =
      input
      |> Enum.slice(1..-1)
      |> Enum.map(&parse_mapping/1)
      |> Enum.into(%{})

    seeds |> Enum.map(fn value -> walk(value, :seed, mappings) end) |> Enum.min()
  end

  defp parse_mapping(map) do
    [from, to] =
      map
      |> Enum.at(0)
      |> String.trim_trailing(" map:")
      |> String.replace("-to-", " ")
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_atom/1)

    mappings =
      map
      |> Enum.slice(1..-1)
      |> Enum.map(&parse_numbers/1)

    {from, {to, mappings}}
  end

  defp parse_numbers(line) do
    line
    |> String.split(" ", trim: true)
    |> Enum.map(fn s -> Integer.parse(s, 10) |> elem(0) end)
  end

  defp walk(value, :location, _), do: value

  defp walk(value, from, mappings) do
    {to, ranges} = mappings[from]
    walk(map(value, ranges), to, mappings)
  end

  defp map(value, ranges) do
    range =
      ranges
      |> Enum.filter(fn range -> in_range(value, range) end)
      |> List.flatten()

    cond do
      Enum.empty?(range) -> value
      true -> value + (Enum.at(range, 0) - Enum.at(range, 1))
    end
  end

  defp in_range(value, range) do
    [_, start, size] = range
    value >= start and value <= start + size
  end
end
