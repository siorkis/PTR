defmodule Lab1.Checkpoint3.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      {Actor, [name: Worker1]}
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
