defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """

  @gigaseconds 1_000_000_000

  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    month_str = String.pad_leading("#{month}", 2, "0")
    day_str = String.pad_leading("#{day}", 2, "0")
    hours_str = String.pad_leading("#{hours}", 2, "0")
    minutes_str = String.pad_leading("#{minutes}", 2, "0")
    seconds_str = String.pad_leading("#{seconds}", 2, "0")

    with {:ok, converted_time} <-
           NaiveDateTime.from_iso8601(
             "#{year}-#{month_str}-#{day_str} #{hours_str}:#{minutes_str}:#{seconds_str}"
           ) do
      added_giga = NaiveDateTime.add(converted_time, @gigaseconds, :second)

      {{added_giga.year, added_giga.month, added_giga.day},
       {added_giga.hour, added_giga.minute, added_giga.second}}
    end
  end
end

IO.inspect(Gigasecond.from({{2011, 4, 25}, {0, 0, 0}}))
