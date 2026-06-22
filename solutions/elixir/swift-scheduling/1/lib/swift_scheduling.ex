defmodule SwiftScheduling do
  @doc """
  Convert delivery date descriptions to actual delivery dates, based on when the meeting started.
  """

  @work_time ~T[08:00:00]

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

  def delivery_date(meeting_date, description) do
    case parse_rule(description) do
      {:m, n} -> compute_month(meeting_date, n)
      {:q, n} -> compute_quarter(meeting_date, n)
      :error -> {:error, :invalid_rule}
    end
  end

  defp compute_month(meeting_start, month) do
    target_year =
      if before_or_in_month?(meeting_start, month) do
        meeting_start.year
      else
        meeting_start.year + 1
      end

    build_first_workday_of_month(target_year, month)
  end

  defp before_or_in_month?(meeting_start, month) do
    meeting_start.month <= month
  end

  defp compute_quarter(meeting_start, quarter) do
    target_year =
      if before_or_in_quarter?(meeting_start, quarter) do
        meeting_start.year
      else
        meeting_start.year + 1
      end

    build_last_workday_of_quarter(target_year, quarter)
  end

  defp before_or_in_quarter?(meeting_start, quarter) do
    current_quarter = quarter_of_month(meeting_start.month)
    current_quarter <= quarter
  end

  defp build_first_workday_of_month(year, month) do
    Date.new!(year, month, 1)
    |> first_workday()
    |> NaiveDateTime.new!(@work_time)
  end

  defp build_last_workday_of_quarter(year, quarter) do
    {_start_month, end_month} = quarter_range(quarter)

    last_day =
      end_month
      |> Date.new!(year, last_day_of_month(year, end_month))
      |> last_workday()

    NaiveDateTime.new!(last_day, @work_time)
  end

  defp first_workday(date) do
    case Date.day_of_week(date) do
      6 -> Date.add(date, 2)
      7 -> Date.add(date, 1)
      _ -> date
    end
  end

  defp last_workday(date) do
    case Date.day_of_week(date) do
      6 -> Date.add(date, -1)
      7 -> Date.add(date, -2)
      _ -> date
    end
  end

  defp quarter_of_month(month), do: div(month - 1, 3) + 1

  defp quarter_range(1), do: {1, 3}
  defp quarter_range(2), do: {4, 6}
  defp quarter_range(3), do: {7, 9}
  defp quarter_range(4), do: {10, 12}

  defp last_day_of_month(year, month) do
    Date.days_in_month(Date.new!(year, month, 1))
  end

  defp parse_rule("Q" <> rest) do
    case Integer.parse(rest) do
      {n, ""} when n in 1..4 -> {:q, n}
      _ -> :error
    end
  end

  defp parse_rule(rule) do
    case Integer.parse(String.trim_trailing(rule, "M")) do
      {n, ""} when n in 1..12 -> {:m, n}
      _ -> :error
    end
  end
end
