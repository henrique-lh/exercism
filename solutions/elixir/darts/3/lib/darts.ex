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
      distance_between_2_points.(x, y) > 5 -> 1
      distance_between_2_points.(x, y) > 1 -> 5
      true -> 10
    end
  end
end

result = Darts.score({0.8, -0.8})
IO.puts(result)
