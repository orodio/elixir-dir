defmodule ListSubSupervisor do
  use Supervisor

  def start_link(list_data_pid) do
    Supervisor.start_link(__MODULE__, list_data_pid)
  end

  def init(list_data_pid) do
    children = [ worker(ListServer, [list_data_pid]) ]
    supervise children, strategy: :one_for_one
  end
end
