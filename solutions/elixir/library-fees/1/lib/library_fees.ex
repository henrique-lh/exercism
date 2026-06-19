defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, datetime} = NaiveDateTime.from_iso8601(string)
    datetime
  end

  def before_noon?(datetime) do
    NaiveDateTime.diff(datetime, NaiveDateTime.beginning_of_day(datetime), :hour) < 12
  end

  def return_date(checkout_datetime) do
    cond do
      before_noon?(checkout_datetime) ->
        NaiveDateTime.to_date(NaiveDateTime.add(checkout_datetime, 28, :day))

      true ->
        NaiveDateTime.to_date(NaiveDateTime.add(checkout_datetime, 29, :day))
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    result = Date.diff(NaiveDateTime.to_date(actual_return_datetime), planned_return_date)
    if result <= 0, do: 0, else: result
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    # Get when return
    naive_checkout = datetime_from_string(checkout)
    must_return = return_date(naive_checkout)

    # Check if it is late
    naive_return = datetime_from_string(return)
    late_days = days_late(must_return, naive_return)

    # Calculate fee considering monday?()
    if monday?(naive_return), do: trunc(late_days * rate * 0.5), else: late_days * rate
  end
end
