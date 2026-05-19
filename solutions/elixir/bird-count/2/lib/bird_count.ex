defmodule BirdCount do
  def today([]), do: nil
  def today(list) do
    # Please implement the today/1 function
    [head | _tail] = list
    head
  end

  def increment_day_count([]), do: [1]
  def increment_day_count(list) do
    # Please implement the increment_day_count/1 function
    [head | tail] = list
    head = head + 1
    [head | tail]
  end

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([head | tail]) do
    # Please implement the has_day_without_birds?/1 function
    cond do
      head !== 0 -> has_day_without_birds?(tail)
      true -> true
    end
  end

  def total([]), do: 0
  def total([head | tail]) do
    # Please implement the total/1 function
    head + total(tail)
  end

  def busy_days([]), do: 0
  def busy_days([head | tail]) do
    # Please implement the busy_days/1 function
    total_of_busy_days = cond do
      head >= 5 -> 1 + busy_days(tail)
      true -> busy_days(tail)
    end
    total_of_busy_days
  end
end
