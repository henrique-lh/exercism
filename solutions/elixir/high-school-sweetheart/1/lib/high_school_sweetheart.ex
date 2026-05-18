defmodule HighSchoolSweetheart do
  def first_letter(name) do
    # Please implement the first_letter/1 function
    name
    |> String.replace(" ", "")
    |> String.replace("\n", "")
    |> String.replace("\t", "")
    |> String.first()
  end

  def initial(name) do
    # Please implement the initial/1 function
    first_letter(name) |> String.upcase() |> Kernel.<>(".")
  end

  def initials(full_name) do
    # Please implement the initials/1 function
    full_name
    |> String.split(" ")
    |> Enum.map(fn x -> initial(x) end)
    |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    # ❤-------------------❤
    # |  X. X.  +  X. X.  |
    # ❤-------------------❤

    # Please implement the pair/2 function
    """
    ❤-------------------❤
    |  #{initials(full_name1)}  +  #{initials(full_name2)}  |
    ❤-------------------❤
    """
  end
end
