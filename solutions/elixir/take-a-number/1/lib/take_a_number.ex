defmodule TakeANumber do
  def start() do
    spawn(__MODULE__, :loop, [0])
  end

  def loop(current_count) do
    receive do
      {:report_state, caller} ->
        send(caller, current_count)
        loop(current_count)

      {:take_a_number, caller} ->
        new_count = current_count + 1
        send(caller, new_count)
        loop(new_count)

      :stop ->
        :ok

      _ ->
        loop(current_count)
    end
  end
end
