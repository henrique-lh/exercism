defmodule HighScore do

  @reset_score 0

  def new() do
    %{}
  end

  def add_player(scores, name, score \\ @reset_score) do
    Map.put(scores, name, score)
  end

  def remove_player(scores, name) do
    Map.delete(scores, name)
  end

  def reset_score(scores, name) do
    Map.put(scores, name, @reset_score)
  end

  def update_score(scores, name, score) do
      Map.update(scores, name, score, fn curr_score -> curr_score + score end)
  end

  def get_players(scores) do
    # Please implement the get_players/1 function
    Map.keys(scores)
  end
end
