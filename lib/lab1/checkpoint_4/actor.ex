defmodule Actor do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  ## Callbacks

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  # @impl true
  # def handle_call(:pop, _from, [head | tail]) do
  #   {:reply, head, tail}
  # end

  # @impl true
  # def handle_cast({:push, head}, tail) do
  #   {:noreply, [head | tail]}
  # end

    @spec echo(any) :: any
    def echo(msg) do
      if msg == "kill" do
        Process.exit(self(), :kill)
      end
      IO.inspect(msg)
    end

    def listen do
      receive do
        {:kill} -> Process.exit(self(), :kill)
      end
      listen()
    end

  def spawn_child() do
    children = [Actor]
    {:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)
    pid
  end

end
