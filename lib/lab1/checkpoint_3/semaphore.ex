defmodule Semaphore do

  def semaphore(n \\ 0) do

    if n == 0 do
      receive do
        :release -> semaphore(1)
      end
    end

    receive do
      {:request, from} ->
        send(from, :granted)
        semaphore(n - 1)

      :release ->
        semaphore(n + 1)
      end
  end

  def request(semaphore) do
    send(semaphore, {:request, self()})

    receive do
      :granted ->
        :ok
    end
  end

  def done(semaphore) do
    send(semaphore, :release)
  end

end

# pid = spawn(Semaphore, :semaphore, [3])
# Semaphore.request(pid)
# Semaphore.done(pid)
