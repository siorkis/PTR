defmodule Supervisorauxiliar1 do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    children = [%{
        id: :b1,
        start: {Balancer1, :start_link, []}},%{
        id: :m1,
        start: {Mostpopular1, :start_link, []}},%{
        id: :storage1,
        start: {Storage1, :start_link, []}}]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
