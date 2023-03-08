defmodule Avg do
  def avg(sum, count \\ 0) do
    receive do
      number when is_integer(number) ->
        sum = sum+number
        count = count+1
        IO.inspect("Current average is: #{sum/count}")
        avg(sum, count)
    end
  end
end

# pid = spawn(Avg, :avg, [10])
# send(pid, 5)
