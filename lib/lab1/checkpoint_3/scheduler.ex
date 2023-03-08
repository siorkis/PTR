defmodule Scheduler do

  use GenServer

  def start_link(state) do
    Supervisor.start_link(__MODULE__, state, name: __MODULE__)
  end

  def risky() do
    answer = Enum.random([true, false])
    if answer do
      IO.inspect("Task sucessful: Miau")
    end

    if !answer do
      IO.inspect("Task fail")
      exit(:boom)
    end
  end

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    risky()
    {:reply, head, tail}
  end

end

# children = [
#   %{
#     id: Scheduler,
#     start: {Scheduler, :start_link, [[:hello]]}
#   }
# ]
# {:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)

#
# GenServer.call(Scheduler, :pop)


# Scheduler.risky()
