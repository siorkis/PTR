defmodule Mod do
  def modify do
    receive do
      message when is_integer(message) -> IO.inspect("Received: #{message+1}")
      message when is_bitstring(message) -> IO.inspect("Received: #{String.downcase(message)}")
      _ -> IO.inspect("Received: I don't know how to HANDLE this!")
    end
    modify()
  end
end

# iex> pid = spawn(Mod, :modify, [])
# iex> send(pid, 1)
# iex> send(pid, "AD")
# iex> send(pid, {1})
