defmodule Monitoring do

  def monitor do
    receive do
      {:exit_because, reason} -> exit(reason)
      {:link_to, pid} -> Process.link(pid)
      {:EXIT, pid, reason} -> IO.inspect("Process #{inspect(pid)} exited because #{reason}")
    end

    monitor()
  end

  def monitoring do
    Process.flag(:trap_exit, true)
    monitor()
  end

end

# pid1 = spawn(Monitoring, :monitoring, [])
# pid2 = spawn(Monitoring, :monitor, [])
# send(pid1, {:link_to, pid2})
# send(pid2, {:exit_because, :bad_thing})
# Process.info(pid2, :status)
# Process.info(pid1, :status)
