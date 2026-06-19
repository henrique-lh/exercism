defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      silent?(input) -> "Fine. Be that way!"
      yelling?(input) and question?(input) -> "Calm down, I know what I'm doing!"
      yelling?(input) -> "Whoa, chill out!"
      question?(input) -> "Sure."
      true -> "Whatever."
    end
  end

  defp silent?(input), do: String.trim(input) == ""

  defp question?(input), do: String.ends_with?(String.trim(input), "?")

  defp yelling?(input) do
    letters = Regex.replace(~r/[^\p{L}]/u, input, "")
    letters != "" and letters == String.upcase(letters)
  end
end
