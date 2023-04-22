defmodule Printer1 do
  use GenServer

  def start_link(id) do
    IO.puts("\n--------- The #{id} Printer ---------")
    GenServer.start_link(__MODULE__, id)
  end

  def init(state) do
    {:ok, state}
  end

  def tweet_text_printer(process_identifier, text) do
    GenServer.cast(process_identifier, text)
  end

  def handle_cast(:kill, state) do
    IO.puts("\n--------- Killed Printer #{state} ---------")
    Balancer1.reset_printer(state)
    {:stop, :normal, state}
  end

  def handle_cast(text, state) do
    case Storage1.lookup(text) do
      true -> Balancer1.printer_discharge(state)
        {:noreply, state}
      false ->
        Storage1.insert(text)
    # text
    # # |> censor()
    # |> IO.puts()
    text = censor1(text)
    IO.puts("\n\n\n\nNr of workers: #{inspect Supervisorprinter1.count()}")
    IO.puts("Text from printer #{state}: \n#{inspect text} --- --- --- --- --- ---\n\n")
    Balancer1.printer_discharge(state)
    {:noreply, state}
    end
  end

  def censor(text) do
    text
    |> String.split()
    |> Enum.map(fn word ->
      if censor_word?(word) do
        String.graphemes(word) |> Enum.map(fn _ -> "*" end) |> Enum.join()
      else
        word
      end
    end)
    |> Enum.join(" ")
  end

  defp censor_word?(word) do
    Censorlist.get_word_list()
    |> Enum.member?(word)
  end


  defp censor1(text) do
    text = URI.encode(text)
    response = HTTPoison.get!("https://www.purgomalum.com/service/plain?text=#{text}")
    Map.get(response, :body)
    # |> censor()
  end
end
