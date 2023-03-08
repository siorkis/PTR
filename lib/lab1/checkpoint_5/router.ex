defmodule Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)


  get "/movies" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Db1.get_all() |> Poison.encode!())
  end


  get "/movies/:id" do # /movies/2
    movie =
      conn.path_params["id"]
      |> String.to_integer()
      |> Db1.get_by_id()
    case movie do
      nil ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(404, "Not Found")
      movie ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, movie |> Poison.encode!())
    end
  end


  post "/movies" do
    {:ok, body, conn} = conn |> Plug.Conn.read_body()
    {:ok, %{
       "title" => title,
       "release_year" => release_year,
       "director" => director}
    } = body |> Poison.decode()
     Db1.create(title, release_year, director)
    send_resp(conn, 201, "")
  end

  # {
  #   "title" : "Cinema",
  #   "release_year" : "3001",
  #   "director" : "Me"
  # }

  put "/movies/:id" do
    id =
      conn.path_params["id"]
      |> String.to_integer()
    {:ok, body, conn} = conn |> Plug.Conn.read_body()
    {:ok, %{
       "title" => title,
       "release_year" => release_year,
       "director" => director}
    } = body |> Poison.decode()
     Db1.put(title, release_year, id, director)
    send_resp(conn, 200, "")
  end

  # /movies/{id}(12)
  # {
  #   "title" : "Cinema2",
  #   "release_year" : "3002",
  #   "director" : "Me2"
  # }


  patch "/movies/:id" do
    id =
      conn.path_params["id"]
      |> String.to_integer()

    {:ok, body, conn} = conn |> Plug.Conn.read_body()

    case Poison.decode(body) do
      {:ok, patch} ->
        updates = for {key, value} <- patch, do: {key, value}
        Db1.patch(id, updates)
        send_resp(conn, 200, "")

      {:error, _} ->
        send_resp(conn, 400, "Invalid JSON in request body")
    end
  end
  # /movies/{id}(12)
  # {
  #   "title" : "Cinema_new_order",
  # }

  delete "/movies/:id" do
    movie =
      conn.path_params["id"]
      |> String.to_integer()
      |> Db1.delete()
    case movie do
      nil ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(404, "Not Found")
      movie ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, movie |> Poison.encode!())
    end
  end


  match _ do
    send_resp(conn, 404, "Oops!")
  end
end
