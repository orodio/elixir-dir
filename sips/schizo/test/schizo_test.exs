defmodule SchizoTest do
  use ExUnit.Case
  doctest Schizo

  test "uppercase doesnt change the first word" do
    assert Schizo.uppercase("foo") == "foo"
  end

  test "uppercase convers the second word to uppercase" do
    assert Schizo.uppercase("foo bar") == "foo BAR"
  end

  test "uppercase convers every other word to uppercase" do
    assert Schizo.uppercase("foo bar baz whee") == "foo BAR baz WHEE"
  end

  test "unvowel doesnt change ther first word" do
    assert Schizo.unvowel("foo") == "foo"
  end

  test "removes the second words vowels" do
    assert Schizo.unvowel("foo bar") == "foo br"
  end

  test "unvowel removes every other words vowels" do
    assert Schizo.unvowel("foo bar baz whee") == "foo br baz wh"
  end
end
