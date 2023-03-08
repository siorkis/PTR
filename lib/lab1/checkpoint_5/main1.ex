defmodule Main1 do
  def api do
    {:ok, _} = Db1.start_link()
    {:ok, _} = Plug.Cowboy.http(Router, [])
  end
end

# Main1.api()
