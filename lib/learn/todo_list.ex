defmodule Learn.TodoList do
  use GenServer

  def init(init_arg) do
    {:ok, init_arg}
  end

  def start(list) do
    {:ok, todos} = GenServer.start(__MODULE__, list)
    todos
  end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def handle_cast({:add, todo}, list) do
    {:noreply, [todo|list]}
  end

  def handle_cast({:remove, todo}, list) do
    {:noreply, List.delete(list, todo)}
  end

  def handle_call(:fetch, _from, fetch) do
    {:reply, fetch, fetch}
  end

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def add(list, todo) do
    GenServer.cast(list, {:add, todo})
  end

  def pop(list) do
    GenServer.call(list, :pop)
  end

  def remove(list, todo) do
    GenServer.cast(list, {:remove, todo})
  end

  def fetch_list(list) do
    GenServer.call(list, :fetch)
  end

  def handle_info(:kill_me_pls, state) do
    {:stop, :normal, state}
  end
end
