defmodule Printer1 do
  use GenServer


  def start_link(id) do
    IO.puts("\nThe #{id} Printer: success")
    GenServer.start_link(__MODULE__, id)
  end

  def init(state) do
    {:ok, state}
  end

  def tweet_text_printer(process_identifier, text) do
    GenServer.cast(process_identifier, text)
  end

  def handle_cast(text, state) do
    if text == "panic" do
      IO.puts("\n\n\n\n\n\t\t ==== Killed Printer ==== \t\t\n\n\n\n\n\n")
      Balancer1.decrement(state)
      {:stop, :normal, state}
    else
      random_time_for_sleep = :rand.uniform(45) + 5
      Process.sleep(random_time_for_sleep)
      IO.inspect(self())
      IO.inspect("Text: \n#{text} \n~FLAG:END_OF_TEXT")
      Balancer1.decrement(state)
      {:noreply, state}
    end
  end
end
