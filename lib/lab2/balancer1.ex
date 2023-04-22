defmodule Balancer1 do
  use GenServer

  def start_link() do
    IO.puts("\nLoad Balancer: success")
    state = Enum.reduce(1..3, %{}, fn (i, acc) ->
      Map.put(acc, i, 0) end)
    #IO.inspect(state <> " Balancer")
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def increment() do
    GenServer.call(__MODULE__, :increment)
  end

  def decrement(id) do
    GenServer.cast(__MODULE__, {:decrement, id})
  end

  def handle_call(:increment, _from, state) do
    id = state
    |> Enum.min_by(fn {_, x} -> x end)
    |> elem(0)
    state = Map.update(state, id, 1, fn x -> x + 1 end)
    {:reply, id, state}
  end

  def handle_cast({:decrement, id}, state) do
    state = Map.update(state, id, 1, fn x -> x - 1 end)
    {:noreply, state}
  end

  def handle_info(:manage, state) do
    Process.send_after(self(), :manage, 5000)
    last_printer = Enum.count(state)
    nr_tasks = Enum.reduce(state, 0, fn {_, v}, acc -> acc + v end)
    requests_per_node = nr_tasks / (last_printer-1)

    # if the nr of request is less then 50 and there are more then 3 workers decrease nr of workers
    if (last_printer > 3 && requests_per_node < 50) do
      last_worker_requests = Map.get(state, last_printer, 0)
      Supervisorprinter1.printer_remove(last_printer)
      state = Map.delete(state, last_printer)
      state = Map.update(state, 1, last_worker_requests, fn x -> x + last_worker_requests end)
      {:noreply, state}
    end
    if (requests_per_node > 100) do
      printer_new_id = Enum.count(state) + 1
      case Supervisorprinter1.printer_new(printer_new_id) do
        :ok -> {:reply, printer_new_id,
        Map.update(state, printer_new_id, 1, fn x -> x + 1 end)}
      end
    else
      id = state
      |> Enum.min_by(fn {_, v} -> v end)
      |> elem(0)
      {:reply, id, Map.update(state, id, 1, fn x -> x + 1 end)}
    end
  end
end
