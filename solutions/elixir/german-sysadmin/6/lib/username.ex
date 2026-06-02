defmodule Username do

  @replacements %{?ä => ~c"ae", ?ö => ~c"oe", ?ü => ~c"ue", ?ß => ~c"ss"}

  def sanitize([]), do: ~c""

  def sanitize([head | tail]) do
    replacement =
      case head do
        char when char in ?a..?z or char === ?_ -> [char]
        char when is_map_key(@replacements, char) -> @replacements[char]
        _ -> ~c""
      end
    replacement ++ sanitize(tail)
  end
end
