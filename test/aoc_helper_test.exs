defmodule AocHelperTest do
  use ExUnit.Case
  doctest AocHelper

  test "greets the world" do
    assert AocHelper.hello() == :world
  end
end
