defmodule Learn.BankAccount do
  use GenServer

  @moduledoc """
    Use:
      {:ok, account} = GenServer.start(Learn.BankAccount, 0)

      GenServer.cast(account, {:deposit, 50})
      GenServer.cast(account, {:withdraw, 25})
      balance = GenServer.call(account, :balance)
  """
  def init(init_arg) do
    {:ok, init_arg}
  end

  def handle_cast({:deposit, amount}, balance) do
    {:noreply, balance + amount}
  end

  def handle_cast({:withdraw, amount}, balance) do
    {:noreply, balance - amount}
  end

  def handle_call(:balance, _from, balance) do
    {:reply, balance, balance}
  end

  @doc """
    Hiding GenServer: with a wrapper function

    Usage:
      account = start(100) => :ok
      deposit(account, 100) => :ok
      withdraw(account, 50) => :ok
      balance(account) => 150
  """

  def start(balance) do
    {:ok, account} = GenServer.start(__MODULE__, balance)
    account
  end

  def deposit(account, amount) do
    GenServer.cast(account, {:deposit, amount})
  end

  def withdraw(account, amount) do
    GenServer.cast(account, {:withdraw, amount})
  end

  def balance(account) do
    GenServer.call(account, :balance)
  end
end
