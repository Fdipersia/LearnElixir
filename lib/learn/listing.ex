defmodule Learn.Listing do
  @prefix Application.compile_env(:learn, :prefix, "salt")

  def length(list) do
    length(list, 0)
  end

  defp length([], count) do
    count
  end

  defp length([_|t], count) do
    length(t, count + 1)
  end

  def each([], _fun) do
    :ok
  end

  def each([h|t], fun) do
    fun.(h)
    each(t, fun)
  end

  list = [
    {"Panchi", 32},
    {"Tom", 33},
    {"Sam", 34},
  ]
  def map(list, fun) do
    do_map(list, fun, [])
  end

  defp do_map([], _, acc) do
    :lists.reverse(acc)
  end

  defp do_map([h|t], fun, acc) do
    result = fun.(h)
    acc = [result | acc]
    do_map(t, fun, acc)
  end

  def encrypt(text) do
    @prefix <> String.reverse(text)
  end
end
