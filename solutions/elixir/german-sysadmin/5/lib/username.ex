defmodule Username do

  def sanitize(username, name \\ ~c"")

  def sanitize([], name) do
    name
  end

  def sanitize(username, name) do
    [head | tail] = username
    case head do
      head when head === ?ä -> sanitize(tail, name ++ ~c"ae")
      head when head == ?ö -> sanitize(tail, name ++ ~c"oe")
      head when head == ?ü -> sanitize(tail, name ++ ~c"ue")
      head when head == ?ß -> sanitize(tail, name ++ ~c"ss")
      head when head < 97 and head != ?_ -> sanitize(tail, name ++ ~c"")
      head when head > 122 and head != ?_ -> sanitize(tail, name ++ ~c"")
      _ -> sanitize(tail, name ++ [head])
    end
  end
end
