defmodule Sequence.Server do
  use GenServer
  require Logger

  defmodule State do
    defstruct val: 0, stash: nil, delta: 1
  end

  @vsn "1"

  ### Public

  def start_link stash do
    GenServer.start_link __MODULE__, stash, name: __MODULE__
  end

  def next do
    GenServer.call __MODULE__, :next
  end

  def inc delta do
    GenServer.cast __MODULE__, { :inc, delta }
  end

  ### GenServer

  def init stash do
    val = Sequence.Stash.get_value stash
    { :ok, %State{ val: val, stash: stash } }
  end

  def handle_call :next, _from, state do
    { :reply, state.val, %{ state | val: state.val + state.delta } }
  end

  def handle_cast { :inc, delta }, state do
    { :noreply, %{ state | val: state.val + delta, delta: delta } }
  end

  def terminate _reason, state do
    Sequence.Stash.save_value state.stash, state.val
  end

  def code_change "0", old_state = { val, stash }, _extra do
    new_state = %State{ val: val, stash: stash, delta: 1 }
    Logger.info "Changing code from 0 to 1"
    Logger.info inspect(old_state)
    Logger.info inspect(new_state)
    { :ok, new_state }
  end
end
