defmodule Mostpopular1 do
  use GenServer

  def start_link() do
    IO.puts("\nMost Popular Analyst: success")
    GenServer.start_link(__MODULE__, {:os.timestamp(), %{}}, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def most_popular(hashtag) do
    GenServer.cast(__MODULE__, hashtag)
  end

  def handle_cast(hashtag, state) do
    hashtags = state
    |> elem(1)
    hashtags = Map.update(hashtags, hashtag, 1, fn x -> x + 1 end)
    time_starting = state
    |> elem(0)
    time_ending = :os.timestamp()
    {_, ending_seconds, ending_microseconds} = time_ending
    {_, starting_seconds, starting_microseconds} = time_starting
    time_passed = (ending_seconds - starting_seconds) + (ending_microseconds - starting_microseconds) / 1000000 # 1000000 microsecons = 1 sec
    if(time_passed > 5) do
      hashtags = hashtags
      |> Enum.sort_by(&elem(&1, 1), &>=/2)
      |> Enum.take(5)
      IO.puts("\n\n\t\t ==== Top 5 hashtags in the last 5 seconds ==== \t\t\n\n")
      hashtags
      |> Enum.each(fn {hashtag, count} ->
        IO.puts("#{count} ----- #{hashtag}") end)
      {:noreply, {:os.timestamp(), %{}}}
    else
      {:noreply, {time_starting, hashtags}}
    end
  end


end
