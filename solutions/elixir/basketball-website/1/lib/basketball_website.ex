defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    [key | tail] = String.split(path, ".")
    value = data[key]

    cond do
      is_map(value) -> extract_from_path(value, Enum.join(tail, "."))
      true -> value
    end
  end

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
