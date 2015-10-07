defmodule Sequence.Supervisor do
  use Supervisor

  def start_link init_num do
    result = { :ok, sup } = Supervisor.start_link __MODULE__, [init_num]
    start_workers sup, init_num
    result
  end

  def start_workers sup, init_num do
    { :ok, stash } = Supervisor.start_child sup, worker(Sequence.Stash, [init_num])
    Supervisor.start_child sup, supervisor(Sequence.SubSupervisor, [stash])
  end

  def init _ do
    supervise [], strategy: :one_for_one
  end
end
