defmodule Mix.Tasks.Encrypt do
  @shortdoc "Encrypts text"
  @moduledoc """
  Takes a -t option to specify the text to encrypt
    mix encrypt -t "Hello World"
  """
  use Mix.Task

  def run(args) do
    {opts, _, _} = OptionParser.parse(args, aliases: [t: :text])
    IO.puts(Learn.Listing.encrypt(opts[:text]))
  end
end
