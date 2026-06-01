defmodule ResistorColorDuo do
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value(colors) do
    map = [
      black: "0",
      brown: "1",
      red: "2",
      orange: "3",
      yellow: "4",
      green: "5",
      blue: "6",
      violet: "7",
      grey: "8",
      white: "9"
    ]
    [first, second | _] = colors
    value =
      cond do
        first == :black -> map[second]
        true -> map[first] <> map[second]
      end
      |> String.to_integer()
    value
  end
end
