# Ptr

This is my repository for PTR lab works wchich can be founded on `lib` folder

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ptr` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ptr, "~> 0.1.0"}
  ]
end
```

Documentation can be viewed in index.html file. If it doesn't work, here full documentation to my project:

### First_checkpoint

#  greetings(str)
```
iex> Greetings.greetings("PTR")
"Hello PTR"
iex> Greetings.greetings("123")
"Hello 123"
```

# unit tests 
```elixir
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
```

### Second_checkpoint
## MathCustom module
# is_prime(int)
```
Function `is_prime/1` check if provided number is prime and return true or false.

iex> MathCustom.is_prime(1)
false
iex> MathCustom.is_prime(2)
true
iex> MathCustom.is_prime(11)
true
iex> MathCustom.is_prime(20)
false
```

# cylinder_aria(int, int)
```
Function `cylinder_aria/2` calculate and return aria of cylinder by it's radius and heigh.

iex> MathCustom.cylinder_aria(5, 10)
471.24
```

# smallest_number(int, int, int)
```
Function `smallest_number/3` takes 3 digits as input and provide the smallest number of those combination.

iex> MathCustom.smallest_number(4, 5, 3)
345
iex> MathCustom.smallest_number(0, 4, 3)
304
iex> MathCustom.smallest_number(0, 0, 3)
3
iex> MathCustom.smallest_number(0, 0, 0)
0
```

## ListCustom module 

# reverse(list)
```
Function `reverse/1` takes as argument a list and return a reversed copy.

iex> list = [1, 2, 3, 4]
iex> ListCustom.reverse(list)
[4, 3, 2, 1]
```
# unique_sum(list)
```
Function `unique_sum/1` takes as argument a list of numbers and return a sum of all uniq ones.

iex> list = [1, 2, 3, 4, 2, 3]
iex> ListCustom.unique_sum(list)
10
```
# random_elem(list, int)
```
Function `random_elem/2` return specific number of random elements from the list.

iex> list = [1, 2, 3, 4]
iex> ListCustom.random_elem(list, 2)
[4, 3]
```
# fibonacci(int)
```
Function `fibonacci/1` return list of provided length of Fibonacci numbers.

iex> ListCustom.fibonacci(10)
[1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
```
# translator (dict, str)
```
Function `translator/2` that with given a dictionary, would translate a sentence.

iex> dict = [mama: "mother", papa: "father"]
iex> string = " mama is with papa "
iex> ListCustom.translator(dict, string)
"mother is with father"
```
# rotate_left(list, int)
```
Function `rotate_left/2` would rotate a list n places to the left

iex> ListCustom.rotate_left([1 , 2 , 4 , 8 , 4] , 3)
[8, 4, 1, 2, 4]
```
# list_right_angle_triangles(int)
```
Function `list_right_angle_triangles/1` would print all possible right angle triangles such that a^2 + b^2 = c^2 with chosen c Max.

iex> ListCustom.list_right_angle_triangles(20)
[{3, 4, 5}, {5, 12, 13}, {6, 8, 10}, {8, 15, 17}, {9, 12, 15}, {12, 16, 20}]
```
# remove_consecutive_duplicates(list)
```
Function `remove_consecutive_duplicates/1` would print list without consecutive duplicated values.

iex> ListCustom.remove_consecutive_duplicates([1, 2, 2, 3, 3, 4, 5])
[1, 2, 3, 4, 5]
```
# line_words(list)
```
Function `line_words/1` with given an array of strings, will return the words that can
be typed using only one row of the letters on an English keyboard layout.

iex> ListCustom.line_words(([" Hello " ," Alaska " ," Dad " ," Success "])
["Dad", "Alaska"]
```
# encode(string, int)
```
Function `encode/2` with given text and shift, will return encrypted text by Caesar cypher.

iex> ListCustom.encode(("lorem", 3))
"oruph"
```
# decode(string, int)
```
Function `decode/2` with given cypher text and same shift, will return original message by Caesar cypher.

iex> ListCustom.decode(("oruph", 3))
"lorem"
```
# letters_combinations(string)
```
Function `letters_combinations/1` with given a string of digits from 2 to 9, would return all
possible letter combinations that the number could represent.

iex> ListCustom.letters_combinations(("23"))
["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]
```
# group_anagrams(list)
```
Function `group_anagrams/1` with given an array of strings, would group the anagrams
together.

iex> ListCustom.group_anagrams((["eat" , "tea" , "tan" , "ate" , "nat" , "bat"]))
%{"abt" => ["bat"], "aet" => ["eat", "tea", "ate"], "ant" => ["tan", "nat"]}
```
# longest_common_prefix(list)
```
Function `longest_common_prefix/1` finds the longest common prefix string amongst a list of strings.

iex> ListCustom.longest_common_prefix((["flower", "flow", "flight"]))
"fl"
```
# to_roman(int)
```
Function `to_roman/1` returns roman representation of given number in range 1...3999

iex> ListCustom.to_roman(13)
"XIII"
```
# factorize(int)
```
Function `factorize/1` returns prime factorization of given number

iex> ListCustom.factorize(13)
[13]
iex> ListCustom.factorize(42)
[7, 3, 2]
```

