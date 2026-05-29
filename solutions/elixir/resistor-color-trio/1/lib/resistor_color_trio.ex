defmodule ResistorColorTrio do

  @kilo 1000
  @mega 1000000
  @giga 1000000000

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
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
    [first, second, zeros | tail] = colors
    how_much_zeros = String.to_integer(map[zeros])
    value =
      cond do
        first == :black -> map[second] <> String.pad_leading("", how_much_zeros, "0")
        true -> map[first] <> map[second] <> String.pad_leading("", how_much_zeros, "0")
      end
      |> String.to_integer()

    IO.puts("#{value}")

    cond do
      value <= 999 -> {value, :ohms}
      div(value, @kilo) <= 999 -> {div(value, @kilo), :kiloohms}
      div(value, @mega) <= 999 -> {div(value, @mega), :megaohms}
      div(value, @giga) <= 999 -> {div(value, @giga), :gigaohms}
    end
  end
end

colors = [:blue, :green, :yellow, :orange]
IO.inspect(ResistorColorTrio.label(colors))
