defmodule Sequence.Stash do
  use GenServer

  def start_link num do
    { :ok, _pid } = GenServer.start_link __MODULE__, num
  end

  def save_value pid, val do
    GenServer.cast pid, {:save_value, val}
  end

  def get_value pid do
    GenServer.call pid, :get_value
  end

  def handle_call :get_value, _from, val do
    {:reply, val, val}
  end

  def handle_cast {:save_value, val}, _cur do
    {:noreply, val}
  end
end
