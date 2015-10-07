defmodule ListData do
  use GenServer

  ### Public
  def start_link do
    GenServer.start_link(__MODULE__, [], [])
  end

  def save_state(pid, state) do
    GenServer.cast(pid, {:save_state, state})
  end

  def get_state(pid) do
    GenServer.call(pid, :get_state)
  end

  ### GenSErver

  def init (state) do
    {:ok, state}
  end

  def handle_cast({:save_state, new_state}, _current_state) do
    {:noreply, new_state}
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end
end
