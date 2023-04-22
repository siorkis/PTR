defmodule Storage1 do
  use GenServer

  def start_link() do
    # new Erlang Term Storage
    GenServer.start_link(__MODULE__,
    :ets.new(:storage1, [:set, :public, :named_table]),
    name: __MODULE__)
  end

  def init(table1) do
    {:ok, table1}
  end

  def lookup(key) do
    GenServer.call(__MODULE__, {:lookup, key})
  end

  def insert(key) do
    GenServer.cast(__MODULE__, {:insert, key})
  end


  def delete(key) do
    GenServer.cast(__MODULE__, {:delete, key})
  end

  # fetch data by key from the storage
  def handle_call({:lookup, key}, _from, table1) do
    case :ets.lookup(table1, key) do
      [{^key, _}] -> {:reply, true, table1}
      [] -> {:reply, false, table1}
    end
  end

  # inserting in the storage
  def handle_cast({:insert, key}, table1) do
    :ets.insert(table1, {key, true})
    {:noreply, table1}
  end
end
