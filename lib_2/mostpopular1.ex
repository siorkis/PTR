defmodule Mostpopular1 do
  use GenServer

  def start_link do
    IO.puts("\n--------- Most Popular Analyst ---------")
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    Process.send_after(self(), :work, 5000)
    {:ok, state}
  end

  def most_popular(hashtag) do
    GenServer.cast(__MODULE__, hashtag)
  end


  def handle_info(:work, state) do
    hashtags = state
    |> Enum.sort_by(&elem(&1, 1), &>=/2)
    |> Enum.take(5)
    case hashtags do
      [] -> {:noreply, %{}}
      _ ->
        IO.puts("\n\n --------- Top 5 hashtags in the last 5 seconds ---------\n\n")
        hashtags
        |> Enum.each(fn {hashtag, count} ->
          IO.puts("#{count} ----- #{hashtag}") end)
        Process.send_after(self(), :work, 5000)
        {:noreply, %{}}
    end
  end

  def handle_cast(hashtag, state) do
    state = Map.update(state, hashtag, 1, fn x -> x + 1 end)
    {:noreply,state}
  end
end
