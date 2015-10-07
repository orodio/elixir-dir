defmodule BankAccount do
  def start, do: await []

  defp await(events) do
    receive do
      { :check_balance, pid }        -> send_balance(events, pid)
      event = { :deposit,  _amount } -> events = [event | events]
      event = { :withdraw, _amount } -> events = [event | events]
    end
    await(events)
  end

  defp send_balance(events, pid), do: Process.send(pid, { :balance, calc_balance(events) }, [])

  defp calc_balance(events), do: Enum.reduce(events, 0, &amount_reducer/2)

  defp amount_reducer({ :deposit,  amount }, acc), do: acc + amount
  defp amount_reducer({ :withdraw, amount }, acc), do: acc - amount
  defp amount_reducer(_event, acc),                do: acc
end

