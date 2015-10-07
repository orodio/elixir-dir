defmodule Ping do
  def start do
    await
  end

  def await do
    receive do
      {:pong, pid} -> Process.send pid, {:ping, self}, []
    end
    await
  end
end
