defmodule Greetings do
  @doc"""
  ## Examples
    iex> Greetings.greetings("PTR")
    "Hello PTR"
    iex> Greetings.greetings("123")
    "Hello 123"
  """
  def greetings(name) do
    "Hello #{name}"
  end
end

# IO.puts Greetings.greetings("PTR")
