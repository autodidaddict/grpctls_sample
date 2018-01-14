defmodule ZombieclientTest do
  use ExUnit.Case
  doctest Zombieclient

  test "greets the world" do
    assert Zombieclient.hello() == :world
  end
end
