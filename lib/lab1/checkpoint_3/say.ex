defmodule Say do
  def say do
    receive do
      message -> IO.inspect(message)
    end

    say()
  end
end

# iex> pid = spawn(Say, :say, [])
# iex> send(pid, "Hello")
