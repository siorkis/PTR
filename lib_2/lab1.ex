defmodule Lab1 do
  def execute() do
    Supervisorprinter1.start_link()
    Supervisorauxiliar1.start_link()
    Supervisorreader1.start_link()
  end
end

# Lab1.execute()
