defmodule Day01 do
  def solve() do
    podium =
      AdventOfCode2022Elixir.get_input_lines("day01")
      |> parse_input_lines([0])
      |> Enum.sort(:desc)
      |> Enum.take(3)

    {hd(podium), Enum.sum(podium)}
  end

  @spec parse_input_lines([String.t()], [number]) :: [number]
  defp parse_input_lines([line | remaining_lines], sums) do
    updated_sums =
      case line do
        "" ->
          [0 | sums]

        calorieStr ->
          calorie = String.to_integer(calorieStr)
          [hd(sums) + calorie | tl(sums)]
      end

    parse_input_lines(remaining_lines, updated_sums)
  end

  defp parse_input_lines([], sums) do
    sums
  end
end
