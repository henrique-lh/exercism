defmodule LineUp do
  @doc """
  Formats a full ticket sentence for the given name and number, including
  the person's name, the ordinal form of the number, and fixed descriptive text.
  """
  @spec format(name :: String.t(), number :: pos_integer()) :: String.t()
  def format(name, number) do
    n = to_string(number)
    pos = cond do
      String.ends_with?(n, "1") and not String.ends_with?(n, "11") -> "st"
      String.ends_with?(n, "2") and not String.ends_with?(n, "12") -> "nd"
      String.ends_with?(n, "3") and not String.ends_with?(n, "13") -> "rd"
      true -> "th"
    end
    "#{name}, you are the #{number}#{pos} customer we serve today. Thank you!"
  end
end
