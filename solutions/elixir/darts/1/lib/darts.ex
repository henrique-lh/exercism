defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do

    distance_between_2_points = fn x, y -> :math.sqrt(x ** 2 + y ** 2) end

    cond do
      distance_between_2_points.(x, y) > 10 -> 0
      abs(x) <= 10 and abs(x) > 5 and abs(y) <= 10 and abs(y) > 5 -> 1
      abs(x) <= 5 and abs(x) > 1 and abs(y) <= 5 and abs(y) > 1 -> 5
      true -> 10
    end
  end
end
