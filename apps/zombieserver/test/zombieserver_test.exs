defmodule ZombieserverTest do
  use ExUnit.Case
  doctest Zombieserver

  test "greets the world" do
    assert Zombieserver.hello() == :world
  end
end
