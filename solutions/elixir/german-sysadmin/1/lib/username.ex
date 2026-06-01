defmodule Username do

  # ä becomes ae
    # ö becomes oe
    # ü becomes ue
    # ß becomes ss

  def sanitize(username, name \\ ~c"")

  def sanitize([], name) do
    name
  end

  def sanitize(username, name) do
    [head | tail] = username
    case head do
      head when head === 228 -> sanitize(tail, name ++ ~c"ae")
      head when head == 246 -> sanitize(tail, name ++ ~c"oe")
      head when head == 252 -> sanitize(tail, name ++ ~c"ue")
      head when head == 223 -> sanitize(tail, name ++ ~c"ss")
      head when head < 97 and head != 95 -> sanitize(tail, name ++ ~c"")
      head when head > 122 and head != 95 -> sanitize(tail, name ++ ~c"")
      _ -> sanitize(tail, name ++ [head])
    end
  end
end

IO.inspect(Username.sanitize(~c"krüger"))
