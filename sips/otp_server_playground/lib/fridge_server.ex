defmodule FridgeServer do
  use GenServer

  ## Public API

  def start_link, do: start_link([])
  def start_link(items) do
    { :ok, fridge } = GenServer.start_link FridgeServer, items, []
    fridge
  end

  def store(pid, item) do
    GenServer.call(pid, { :store, :bacon })
  end

  def take(pid, item) do
    GenServer.call(pid, { :take, item })
  end

  ## GenServer API

  def init(items) do
    { :ok, items }
  end

  def handle_call({:store, item}, _from, items) do
    {:reply, :ok, [item | items]}
  end

  def handle_call({:take, item}, _from, items) do
    case Enum.member?(items, item) do
      true ->
        {:reply, {:ok, item}, List.delete(items, item)}
      false ->
        {:reply, :not_found, items}
    end
  end
end
