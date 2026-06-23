defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &{&1.price})
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, fn map -> is_nil(map[:price]) end)
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn map ->
      Map.put(map, :name, String.replace(map[:name], old_word, new_word))
    end)
  end

  def increase_quantity(item, count) do
    quantity_map = item[:quantity_by_size]
    Map.replace(item, :quantity_by_size, Map.new(quantity_map, fn {k, v} -> {k, v + count} end))
  end

  def total_quantity(item) do
    quantity_map = item[:quantity_by_size]
    Enum.reduce(quantity_map, 0, fn {_, v}, acc -> acc + v end)
  end
end
