defmodule LearnTest do
  use ExUnit.Case
  doctest Learn

  test "greets the world" do
    assert Learn.hello() == :world
  end

  test "assert the truth" do
    assert(true)
  end

  test "should return length" do
    airport = Faker.Airports.name()
    airports = [airport, airport]
    assert Learn.Listing.length(airports) == 2
  end

  test "should encrypt text" do
    text = Faker.StarWars.quote()
    assert Learn.Listing.encrypt(text) != text, "Could not encrypt"
  end

  test "should refute" do
    refute false == true
  end
end
