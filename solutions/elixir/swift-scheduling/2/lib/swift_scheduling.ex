defmodule SwiftScheduling do
  @doc """
  Convert delivery date descriptions to actual delivery dates, based on when the meeting started.
  """

  @spec delivery_date(NaiveDateTime.t(), String.t()) :: NaiveDateTime.t()
  def delivery_date(meeting_date, "NOW"), do: NaiveDateTime.add(meeting_date, 2, :hour)

  def delivery_date(meeting_date, "ASAP") do
    cond do
      meeting_date.hour < 13 ->
        meeting_date |> NaiveDateTime.to_date() |> NaiveDateTime.new!(~T[17:00:00])

      true ->
        meeting_date |> NaiveDateTime.to_date() |> Date.add(1) |> NaiveDateTime.new!(~T[13:00:00])
    end
  end

  def delivery_date(meeting_date, "EOW") do
    date = NaiveDateTime.to_date(meeting_date)
    day_of_week = Date.day_of_week(date)
    days_until_friday = 5 - day_of_week

    cond do
      day_of_week <= 3 -> date |> Date.add(days_until_friday) |> NaiveDateTime.new!(~T[17:00:00])
      true -> date |> Date.add(days_until_friday + 2) |> NaiveDateTime.new!(~T[20:00:00])
    end
  end

  def delivery_date(meeting_date, "Q" <> quarter_str) do
    quarter = String.to_integer(quarter_str)

    quarter_date =
      if Date.quarter_of_year(meeting_date) <= quarter do
        Date.new!(meeting_date.year, 3 * quarter, 1)
      else
        Date.new!(meeting_date.year + 1, 3 * quarter, 1)
      end

    quarter_date
    |> Date.end_of_month()
    |> NaiveDateTime.new!(~T[08:00:00])
    |> find_next_workday(-1)
  end

  def delivery_date(meeting_date, description) do
    [_, month_str] = Regex.run(~r/(\d+)M/, description)
    month_int = String.to_integer(month_str)

    date =
      if meeting_date.month < month_int do
        Date.new!(meeting_date.year, month_int, 1)
      else
        Date.new!(meeting_date.year + 1, month_int, 1)
      end

    date
    |> NaiveDateTime.new!(~T[08:00:00])
    |> find_next_workday(1)
  end

  defp find_next_workday(date, direction) do
    cond do
      Date.day_of_week(date) <= 5 ->
        date

      Date.day_of_week(date) > 5 ->
        find_next_workday(NaiveDateTime.add(date, direction, :day), direction)
    end
  end
end
