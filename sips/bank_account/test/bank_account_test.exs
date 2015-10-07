defmodule BankAccountTest do
  use ExUnit.Case

  test "starts off with a balance of 0" do
    account = spawn_link(BankAccount, :start, [])
    assert_balance(account, 0)
  end

  test "has balance incremented by the amount of a deposit" do
    account = spawn_link(BankAccount, :start, [])
    Process.send(account, {:deposit, 10}, [])
    assert_balance(account, 10)
  end

  test "has balance decremented by the amount of a withdrawals" do
    account = spawn_link(BankAccount, :start, [])
    Process.send(account, {:deposit, 20}, [])
    Process.send(account, {:withdraw, 10}, [])
    assert_balance(account, 10)
  end

  defp assert_balance(account, expected_balance) do
    Process.send(account, {:check_balance, self}, [])
    assert_receive {:balance, expected_balance}
  end
end
