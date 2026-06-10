defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      equal?(a, b) -> :equal
      sublist?(b, a) -> :sublist
      sublist?(a, b) -> :superlist
      true -> :unequal
    end
  end

  defp equal?(a, b), do: a === b

  defp sublist?(a, b) when length(a) < length(b), do: false

  defp sublist?(a, b) do
    sub = Enum.take(a, length(b))
    equal?(sub, b) or sublist?(tl(a), b)
  end
end
