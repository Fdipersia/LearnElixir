defmodule Learn.TodoList do
  use GenServer

  def init(init_arg) do
    {:ok, init_arg}
  end

  def start(list) do
    {:ok, todos} = GenServer.start(__MODULE__, list)
    todos
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

  def add(list, todo) do
    GenServer.cast(list, {:add, todo})
  end

  def remove(list, todo) do
    GenServer.cast(list, {:remove, todo})
  end

  def fetch_list(list) do
    GenServer.call(list, :fetch)
  end
end
