defmodule Db1 do
  use Agent

  def start_link do
    Agent.start_link(
      fn ->
        {:ok, movies_json} = File.read("C:/univer programs/sem 6/PTR/lib/lab1/checkpoint_5/movies.json")
        {:ok, state} = Poison.decode(movies_json)
        state
      end,
      name: __MODULE__
    )
  end


  def get_all do
    Agent.get(__MODULE__, & &1)
  end


  def get_by_id(id) do
    Agent.get(__MODULE__, &Enum.find(&1, fn %{"id" => value} -> value == id end))
  end


  def create(title, release_year, director) do
    Agent.update(__MODULE__, fn state ->
      db_len =
        state
        |> Enum.reduce(-1, fn %{"id" => value}, acc -> if value > acc, do: value, else: acc end)
      state ++
        [
          %{
            "title" => title,
            "release_year" => release_year,
            "id" => db_len + 1,
            "director" => director
          }
        ]
    end)
  end


  def put(title, release_year, id, director) do
    Agent.update(__MODULE__, fn state ->
      Enum.filter(state, fn %{"id" => value} -> id != value end) ++
        [
          %{
            "title" => title,
            "release_year" => release_year,
            "id" => id,
            "director" => director
          }
        ]
    end)
  end

  def patch(id, updates) do
    Agent.update(__MODULE__, fn state ->
      Enum.map(state, fn movie ->
        if movie["id"] == id do
          Map.merge(movie, Enum.into(updates, %{}))
        else
          movie
        end
      end)
    end)
  end

  def delete(id) do
    Agent.get_and_update(__MODULE__, fn state ->
      {
        state |> Enum.find(fn %{"id" => value} -> id == value end),
        state |> Enum.filter(fn %{"id" => value} -> id != value end)
      }
    end)
  end
end
