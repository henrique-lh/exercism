defmodule SquareRoot do

  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand), do: calculate(radicand, 0, radicand)

  def calculate(_, low, high) when low > high, do: high

  def calculate(radicand, low, high) do
    middle = div(high + low, 2)
    mid_squared = middle * middle
    cond do
      mid_squared === radicand -> middle
      mid_squared > radicand -> calculate(radicand, low, middle - 1)
      true -> calculate(radicand, middle + 1, high)
    end
  end
end

IO.puts("sqrt = #{SquareRoot.calculate(11)}")
