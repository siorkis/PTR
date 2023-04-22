defmodule Supervisorprinter1 do
  use Supervisor

  def start_link() do
    process_identifier = Supervisor.start_link(__MODULE__, nr_of_workers: 5, name: __MODULE__)
    |> elem(1)
    Process.register(process_identifier, __MODULE__)
  end

  def init(args) do
    children = Enum.map(1..args[:nr_of_workers],
    fn i -> %{
        id: i,
        start: {Printer1, :start_link, [i]}}
    end)
    children = children ++ [%{
        id: :b1,
        start: {Balancer1, :start_link, []} }, %{
        id: :m1,
        start: {Mostpopular1, :start_link, []}}]
    Supervisor.init(children, strategy: :one_for_one)
  end

  def count() do
    Supervisor.count_children(__MODULE__)
  end

  def process_identifier_not_occupied(id) do
    Supervisor.which_children(__MODULE__)
    |> Enum.find(fn {i, _, _, _} ->
      i == id end)
    |> elem(1)
  end

  def tweet_text_printer(text) do
    id = Balancer1.increment()
    process_identifier = process_identifier_not_occupied(id)
    Printer1.tweet_text_printer(process_identifier, text)
  end

  def add_worker() do
    :ok
  end

  def remove_last_worker() do
      :ok
  end

  def get_workers() do
    :ok
  end

  def printer_new(id) do
    pid = child_printer_pid(id)
    case pid do
      nil -> printer_start(id)
      _ -> printer_restart(id)
    end
  end

  def printer_start(id) do
    case Supervisor.start_child(__MODULE__, %{
      id: id,
      start: {Printer1, :start_link, [id]}}) do {:ok, _} -> :ok
    end
  end

  def printer_restart(id) do
    Supervisor.restart_child(__MODULE__, id)
  end

  def printer_remove(id) do
    Supervisor.terminate_child(__MODULE__, id)
  end

  def child_printer_pid(id) do
    case Supervisor.which_children(__MODULE__)
    |> Enum.find(fn {i, _, _, _} -> i == id end) do
      {_, pid, _, _} -> pid
      nil -> nil
    end
  end

end
