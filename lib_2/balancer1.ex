defmodule Balancer1 do
  use GenServer

  def start_link do
    IO.puts("\n--------- Load Balancer ---------")
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(_state) do
    # 5000 miliseconds = 5 sec
    Process.send_after(self(), :work, 5000)
    Enum.each(1..3, fn i -> Supervisorprinter1.printer_new(i) end)
    {:ok, Enum.reduce(1..3, %{}, fn (i, acc) ->
      Map.put(acc, i, 0) end)}
  end

  def who_not_occupied() do
    GenServer.call(__MODULE__, :who_not_occupied)
  end

  def any_printer() do
    GenServer.call(__MODULE__, :any_printer)
  end



  def handle_call(:any_printer, _from, state) do
    id = Enum.random(1..Enum.count(state))
    {:reply, id, Map.update(state, id, 1, fn x -> x + 1 end)}
  end

  def handle_call(:who_not_occupied, _from, state) do
    all_printers = Enum.count(state)
    nr_tasks = Enum.reduce(state, 0, fn {_, v}, acc -> acc + v end)

    requests_per_node = nr_tasks / all_printers
    # if the nr of request is bigger then 100
    # increase number of printers
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



  def printer_discharge(id) do
    GenServer.cast(__MODULE__, {:printer_discharge, id})
  end

  def reset_printer(id) do
    GenServer.cast(__MODULE__, {:reset_printer, id})
  end

  def handle_info(:work, state) do
    # 5000 miliseconds = 5 sec
    Process.send_after(self(), :work, 5000)
    all_printers = Enum.count(state)
    nr_tasks = Enum.reduce(state, 0, fn {_, v}, acc -> acc + v end)

    requests_per_node = nr_tasks / (all_printers-1)
    # if the nr of request is less then 50 and there are more then 3 workers
    # decrease nr of workers
    if (all_printers > 3 && requests_per_node < 50) do
      last_worker_requests = Map.get(state, all_printers, 0)
      Supervisorprinter1.printer_remove(all_printers) # all_printers mean as well the last printer
      state = Map.delete(state, all_printers)
      state = Map.update(state, 1, last_worker_requests, fn x -> x + last_worker_requests end)
      {:noreply, state}
    else
      {:noreply, state}
    end
  end


  def handle_cast({:reset_printer, id}, state) do
    case Map.get(state, id) do
      nil -> {:noreply, state}
      _ -> {:noreply, Map.update(state, id, 0, fn _ -> 0 end)}
    end
  end

  def handle_cast({:printer_discharge, id}, state) do
    case Map.get(state, id) do
      nil -> {:noreply, state}
      _ -> {:noreply, Map.update(state, id, 0, fn x -> x - 1 end)}
    end
  end


end
