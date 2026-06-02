defmodule NameBadge do

  def print(id, name, department) do
    check_id = if is_nil(id), do: "#{name} - ", else: "[#{id}] - #{name} - "
    check_departament = if is_nil(department), do: "OWNER", else: String.upcase(department)
    check_id <> check_departament
  end
end

IO.puts(NameBadge.print(nil, "Barbara White", "Security"))
