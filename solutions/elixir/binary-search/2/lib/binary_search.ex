defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """
  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  defp search({}, _key), do: :not_found

  def search(numbers, key) do
    search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  defp search(numbers, key, 0, 1) when elem(numbers, 0) == key, do: {:ok, 0}

  defp search(numbers, key, low, high) when div(high - low, 2) == 0 and elem(numbers, high) == key, do: {:ok, high}

  defp search(numbers, key, low, high) do
    middle = div(high - low, 2) + low
    value = elem(numbers, middle)

    cond do
      value === key -> {:ok, middle}
      middle == high or middle == low -> :not_found
      value < key -> search(numbers, key, middle, high)
      value > key -> search(numbers, key, low, middle)
    end
  end
end
