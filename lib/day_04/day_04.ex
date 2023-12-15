defmodule Day04 do
  def part1 do
    File.read!("lib/day_04/part1.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.map(&intersection_count/1)
    |> Enum.filter(fn count -> count > 0 end)
    |> Enum.map(fn count -> :math.pow(2, count - 1) end)
    |> Enum.sum()
  end

  def part2 do
    counts =
      File.read!("lib/day_04/part2.txt")
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_line/1)
      |> Enum.map(&intersection_count/1)
      |> Enum.with_index()

    get_copies(counts, counts)
    |> IO.inspect()
    |> Enum.count()
  end

  defp parse_line(line) do
    numbers = line |> String.split(":") |> Enum.at(1)
    [winning, ihave] = numbers |> String.split("|", trim: true)

    winning =
      winning
      |> String.split(" ", trim: true)
      |> Enum.map(fn s -> Integer.parse(s, 10) |> elem(0) end)

    ihave =
      ihave
      |> String.split(" ", trim: true)
      |> Enum.map(fn s -> Integer.parse(s, 10) |> elem(0) end)

    {winning, ihave}
  end

  defp intersection_count({winning, ihave}) do
    winning = MapSet.new(winning)
    ihave = MapSet.new(ihave)
    MapSet.intersection(winning, ihave) |> MapSet.size()
  end

  defp get_copies(_, []), do: []

  defp get_copies(original_counts, running_counts) do
    copies =
      running_counts
      |> Enum.map(fn {count, index} ->
        slice = original_counts |> Enum.drop(index + 1) |> Enum.take(count)
        get_copies(original_counts, slice)
      end)
      |> List.flatten()

    Enum.concat(running_counts, copies)
  end
end
