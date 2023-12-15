defmodule Day03 do
  alias Day03.Math

  def part1 do
    windows =
      File.read!("lib/day_03/part1.txt")
      |> String.split("\n", trim: true)
      |> padding()
      |> Enum.chunk_every(3, 1, :discard)

    windows
    |> Enum.map(&process_window/1)
    |> IO.inspect()
    |> List.flatten()
    |> Enum.map(fn x -> elem(x, 0) end)
    |> Enum.map(fn s -> Integer.parse(s, 10) |> elem(0) end)
    |> Enum.sum()
  end

  defp padding(lines) do
    padding_line = String.duplicate(".", Enum.at(lines, 0) |> String.length())

    lines
    |> List.insert_at(0, padding_line)
    |> List.insert_at(Enum.count(lines) + 1, padding_line)
  end

  defp process_window(window) do
    middle_line = Enum.at(window, 1)
    numbers = numbers_with_position(middle_line)

    numbers
    |> Enum.filter(fn {_, {index, length}} ->
      is_attached(index, length, window)
    end)
  end

  defp numbers_with_position(line) do
    numbers = Regex.scan(~r/[0-9]+/, line) |> List.flatten()
    position = Regex.scan(~r/[0-9]+/, line, return: :index) |> List.flatten()
    Enum.zip(numbers, position)
  end

  defp is_attached(index, length, window) do
    window
    |> Enum.map(fn line -> process_line(index, length, line) end)
    |> List.flatten()
    |> Enum.empty?()
    |> Kernel.not()
  end

  defp process_line(index, length, line) do
    start_index = Math.max(0, index - 1)
    end_index = Math.min(String.length(line), index + length)

    line
    |> String.slice(start_index..end_index)
    |> String.replace(~r/[0-9\.]/, "")
    |> String.to_charlist()
  end
end
