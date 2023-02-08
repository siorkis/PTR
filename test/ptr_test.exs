defmodule PtrTest do
  use ExUnit.Case

  # positive tests

  doctest Greetings
  doctest MathCustom

  # negative tests

  test "greeting negative test" do
    refute Greetings.greetings("hi") == "Hello PTR"
  end

  test "is_prime negative test" do
    refute MathCustom.is_prime(3) == false
    refute MathCustom.is_prime(4) == true
  end

  test "cylinder_aria negative test" do
    refute MathCustom.cylinder_aria(5, 10) != 471.24
  end
end
