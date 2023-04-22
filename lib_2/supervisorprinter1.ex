defmodule Supervisorprinter1 do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    Supervisor.init([], strategy: :one_for_one)
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

  def print(text, id) do
    process_identifier = child_printer_pid(id)
    Printer1.tweet_text_printer(process_identifier, text)
  end


  # def get_worker_messages(pid) do
  #   {:messages, messages} = Process.info(pid, :messages)
  #   Enum.map(messages, fn {_, msg} -> msg end)
  # end

  def count() do
    Supervisor.count_children(__MODULE__)
    |> Map.get(:workers, 0)
  end
end
