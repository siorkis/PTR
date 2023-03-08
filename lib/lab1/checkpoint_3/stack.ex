defmodule Stack do
  use GenServer

  # Client

  def push(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  def new_queue() do
    {:ok, pid} = GenServer.start_link(Stack, [:hello])
    pid
  end

  # Server (callbacks)

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end
end

# pid = Stack.new_queue()
# Stack.push(pid, 42)
# Stack.pop(pid)
