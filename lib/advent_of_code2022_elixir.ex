defmodule AdventOfCode2022Elixir do
  @spec get_input_lines(String.t()) :: [String.t()]
  def get_input_lines(filename) do
    File.read!("inputs/#{filename}.txt")
    |> String.trim()
    |> String.split("\r\n", trim: false)
  end
end
