defmodule StringProcessor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
    |> elem(1)
  end

  def init(_) do
    children = [
      %{
        id: :replacer,
        start: {Replacer, :start_link, []}
      },
      %{
        id: :splitter,
        start: {Splitter, :start_link, []}
      },
      %{
        id: :joiner,
        start: {Joiner, :start_link, []}
      }
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end

  def process(msg) do
    msg
    |> Splitter.split()
    |> Replacer.replace()
    |> Joiner.join()
  end

end

defmodule Splitter do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def split(msg) do
    GenServer.call(__MODULE__, msg)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(msg, _from, state) do
    {:reply, String.split(msg), state}
  end
end

defmodule Replacer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def replace(msg) do
    GenServer.call(__MODULE__, msg)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(msg, _from, state) do
    msg = Enum.map(msg, fn word ->
      String.downcase(word)
      |> String.replace("n", "{*}")
      |> String.replace("m", "n")
      |> String.replace("{*}", "m")
    end)

    {:reply, msg , state}
  end
end

defmodule Joiner do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def join(msg) do
    GenServer.call(__MODULE__, msg)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(msg, _from, state) do
    {:reply, Enum.join(msg, " "), state}
  end
end

# from check_4

# iex
# c("string_processor.ex")
# StringProcessor.start_link()
# StringProcessor.process("This is a message to be processed.")
