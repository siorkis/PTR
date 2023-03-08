defmodule Worker do
  def start_link(id) do
    pid = spawn_link(__MODULE__, :loop, [id, true])
    {:ok, pid}
  end

  def loop(id, first_time \\ false) do
    if first_time, do: IO.puts("The worker node with id #{id} has been started")

    receive do
      {:echo, message} ->
        IO.puts("Echo from worker node with id #{id}: #{message}")
        loop(id)

      {:die} ->
        IO.puts("The worker node with id #{id} has been killed")
        exit(:kill)
    end
  end

  def child_spec(id) do
    %{
      id: id,
      start: {__MODULE__, :start_link, [id]}
    }
  end
end

defmodule WorkerSupervisor do
  use Supervisor

  def start_link(n) do
    Supervisor.start_link(__MODULE__, n, name: __MODULE__)
  end

  @impl true
  def init(n) do
    children = 1..n |> Enum.map(&Worker.child_spec(&1))
    Supervisor.init(children, strategy: :one_for_one)
  end

  def get_worker(id) do
    {^id, pid, _, _} =
      __MODULE__
      |> Supervisor.which_children()
      |> Enum.find(fn {worker_id, _, _, _} -> worker_id == id end)

    pid
  end
end


#Driver code
# start a supervisor with 3 worker nodes
{:ok, supervisor} = WorkerSupervisor.start_link(3)

# get the pid of the worker with id 2
worker_pid = WorkerSupervisor.get_worker(2)

# send a message to the worker
send(worker_pid, {:echo, "hello"})

# kill the worker
send(worker_pid, {:die})

# wait for a few seconds to allow the supervisor to restart the worker
:timer.sleep(5000)

# get the pid of the restarted worker
worker_pid = WorkerSupervisor.get_worker(2)

# send a message to the restarted worker
send(worker_pid, {:echo, "world"})
