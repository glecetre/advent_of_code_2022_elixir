defmodule Day02 do
  @spec solve :: {number, number}
  def solve() do
    instruction_lines = AdventOfCode2022Elixir.get_input_lines("day02")

    part1_score =
      instruction_lines
      |> get_game_scores([], mode: :specify_move)
      |> Enum.sum()

    part2_score =
      instruction_lines
      |> get_game_scores([], mode: :specify_outcome)
      |> Enum.sum()

    {part1_score, part2_score}
  end

  @move_score %{
    "X" => 1,
    "Y" => 2,
    "Z" => 3
  }

  @outcome_score %{
    lose: 0,
    draw: 3,
    win: 6
  }

  @outcome_from_char %{
    "X" => :lose,
    "Y" => :draw,
    "Z" => :win
  }

  @spec get_game_scores([String.t()], [number], mode: :specify_move | :specify_outcome) :: [
          number
        ]
  defp get_game_scores([line | remaining_lines], scores, mode: mode)
       when mode in [:specify_move, :specify_outcome] do
    {opponent_move, instruction} = String.split_at(line, 1)
    instruction = String.trim(instruction)

    move_score =
      case mode do
        :specify_move -> get_game_score_from_moves(opponent_move, instruction)
        :specify_outcome -> get_game_score_from_outcome(opponent_move, instruction)
      end

    get_game_scores(remaining_lines, [move_score | scores], mode: mode)
  end

  defp get_game_scores([], scores, _) do
    scores
  end

  @spec get_game_score_from_moves(String.t(), String.t()) :: number
  defp get_game_score_from_moves(opponent_move, player_move) do
    @move_score[player_move] +
      case opponent_move do
        "A" ->
          case player_move do
            "X" -> @outcome_score.draw
            "Y" -> @outcome_score.win
            "Z" -> @outcome_score.lose
          end

        "B" ->
          case player_move do
            "X" -> @outcome_score.lose
            "Y" -> @outcome_score.draw
            "Z" -> @outcome_score.win
          end

        "C" ->
          case player_move do
            "X" -> @outcome_score.win
            "Y" -> @outcome_score.lose
            "Z" -> @outcome_score.draw
          end
      end
  end

  @spec get_game_score_from_outcome(String.t(), String.t()) :: number
  defp get_game_score_from_outcome(opponent_move, expected_outcome) do
    @outcome_score[@outcome_from_char[expected_outcome]] +
      case opponent_move do
        "A" ->
          case expected_outcome do
            "X" -> @move_score["Z"]
            "Y" -> @move_score["X"]
            "Z" -> @move_score["Y"]
          end

        "B" ->
          case expected_outcome do
            "X" -> @move_score["X"]
            "Y" -> @move_score["Y"]
            "Z" -> @move_score["Z"]
          end

        "C" ->
          case expected_outcome do
            "X" -> @move_score["Y"]
            "Y" -> @move_score["Z"]
            "Z" -> @move_score["X"]
          end
      end
  end
end
