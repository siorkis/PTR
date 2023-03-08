defmodule ListCustom do
  @dict %{"2" => ["a", "b", "c"], "3" => ["d","e","f"], "4" => ["g","h","i"], "5" => ["j","k","l"], "6" => ["m","n","o"], "7" => ["p","q","r"], "8" => ["s","t","u"], "9" => ["v","w","x"]}
  @row1 "qwertyuiop"
  @row2 "asdfghjkl"
  @row3 "zxcvbnm"


  def reverse_2(list, number \\ 0, reversed_list \\ []) do
    if number == 0 and length(list) == 0 and length(reversed_list) != 0 do
      reversed_list
    else
      if number == 0 do
        num = length(list)
        reversed_list = []
        reverse_2(list, num, reversed_list)
      end

      item = List.first(list)
      reversed_list = [item | reversed_list]
      list = List.delete_at(list, 0)
      num = length(list)

      reverse_2(list, num, reversed_list)
    end
  end

  @doc"""
  Function `reverse/1` takes as argument a list and return a reversed copy.
  ## Example
  iex> list = [1, 2, 3, 4]
  iex> ListCustom.reverse(list)
  [4, 3, 2, 1]
  """
  def reverse(list) do
    Enum.reverse(list)
  end

  @doc"""
  Function `unique_sum/1` takes as argument a list of numbers and return a sum of all uniq ones.
  ## Example
  iex> list = [1, 2, 3, 4, 2, 3]
  iex> ListCustom.unique_sum(list)
  10
  """
  def unique_sum(list) do
    Tuple.sum(List.to_tuple(Enum.uniq(list)))
  end

  @doc"""
  Function `random_elem/2` return specific number of random elements from the list.
  ## Example
  iex> list = [1, 2, 3, 4]
  iex> ListCustom.random_elem(list, 2)
  [4, 3]
  """
  def random_elem(list, number, return_list \\ []) do
    if number == 0 do
      return_list
    else
      return_list = [Enum.random(list) | return_list]
      random_elem(list, number - 1, return_list)
    end
  end

  @doc"""
  Function `fibonacci/1` return list of provided length of Fibonacci numbers.
  ## Example
  iex> ListCustom.fibonacci(10)
  [1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
  """
  def fibonacci(number, list \\ []) do
    if number == 0 do
      list
    else
      list = [fibonacci_core(number) | list]
      fibonacci(number - 1, list)
    end
  end

  defp fibonacci_core(number) do
    if number == 1 or number === 2 do
      number
    else
      fibonacci_core(number - 1) + fibonacci_core(number - 2)
    end
  end

  @doc"""
  Function `translator/2` that with given a dictionary, would translate a sentence.
  ## Example
  iex> dict = [mama: "mother", papa: "father"]
  iex> string = " mama is with papa "
  iex> ListCustom.translator(dict, string)
  "mother is with father"
  """
  def translator(dict, string) do
    Enum.join(translator_core(dict, string), " ")
  end

  defp translator_core(dict, string) do
    # dict = [mama: "mother", papa: "father"]
    match_list = String.split(string)
    translated_list = []
    for word <- match_list do
      if Map.has_key?(Enum.into(dict, %{}), String.to_atom(word)) do
        _translated_list = translated_list ++ dict[String.to_atom(word)]
      else
        _translated_list = translated_list ++ word
      end

    end
  end

  @doc"""
  Function `rotate_left/2` would rotate a list n places to the left
  ## Example
  iex> ListCustom.rotate_left([1 , 2 , 4 , 8 , 4] , 3)
  [8, 4, 1, 2, 4]
  """
  def rotate_left(list, number) do
    string = String.duplicate("a ", Enum.count(list))
    string = " " <> string
    rotated_list = String.split(string, " ", trim: true)
    rotate_left(list, number, Enum.count(list), rotated_list)
  end

  defp rotate_left(list, number, counter, rotated_list) when counter > 0 do
    rotated_list = List.replace_at(rotated_list, counter-4, List.last(list))
    list = Enum.drop(list, -1)
    rotate_left(list, number, counter-1, rotated_list)
  end

  defp rotate_left(_list, _number, 0, rotated_list) do
    rotated_list
  end

  # def list_right_angle_triangles() do
  #   x = 20
  #   # x = y = 20
  #   # c = trunc(:math.sqrt(x**2 + y**2))
  #   return_list = []
  #   list_right_angle_triangles(x, return_list)
  #   return_list
  # end

  # def list_right_angle_triangles(x, return_list) when x > 0 do
  #   y = 20
  #   list_right_angle_triangles(x, y, return_list)
  #   list_right_angle_triangles(x - 1, return_list)
  # end

  # def list_right_angle_triangles(x, y, return_list) when x > 0 do
  #   c = trunc(:math.sqrt(x**2 + y**2))
  #   list_right_angle_triangles(x, y, c, return_list)
  #   list_right_angle_triangles(x - 1, y, return_list)
  # end

  # def list_right_angle_triangles(x, y, c, return_list) when y > 0 do
  #   if (x**2 + y**2) == c**2 do
  #     return_list = [[x, y, c] | return_list]
  #     list_right_angle_triangles(x, y - 1, c, return_list)
  #   else
  #     list_right_angle_triangles(x, y - 1, c, return_list)
  #   end
  # end

  # def list_right_angle_triangles() do
  #   Enum.each(1..20, fn(x) ->
  #     Enum.each(x..20, fn(y) ->
  #       Enum.each(y..20, fn(c) ->
  #         Enum.filter([x, y, c], fn(x) ->
  #           if x**2 + y**2 == c**2 do
  #             IO.inspect [x, y, c]
  #           end
  #         end)
  #       end)
  #     end)
  #   end)
  # end

  @doc"""
  Function `list_right_angle_triangles/1` would print all possible right angle triangles such that a^2 + b^2 = c^2 with chosen c Max.
  ## Example
  iex> ListCustom.list_right_angle_triangles(20)
  [{3, 4, 5}, {5, 12, 13}, {6, 8, 10}, {8, 15, 17}, {9, 12, 15}, {12, 16, 20}]
  """
  def list_right_angle_triangles(limit) do
    # limit = 20
    Enum.to_list(list_right_angle_triangles_core(limit))
  end

  defp list_right_angle_triangles_core(limit) do
    for a <- 1..limit, b <- a..limit, c <- b..limit, c*c == a*a + b*b, do: {a, b, c}
  end

  @doc"""
  Function `remove_consecutive_duplicates/1` would print list without consecutive duplicated values.
  ## Example
  iex> ListCustom.remove_consecutive_duplicates([1, 2, 2, 3, 3, 4, 5])
  [1, 2, 3, 4, 5]
  """
  def remove_consecutive_duplicates(list) do
    Enum.dedup(list)
  end

  @doc"""
  Function `line_words/1` with given an array of strings, will return the words that can
  be typed using only one row of the letters on an English keyboard layout.
  ## Example
  iex> ListCustom.line_words(([" Hello " ," Alaska " ," Dad " ," Success "])
  ["Dad", "Alaska"]
  """
  def line_words(list) do
    storage_list = []
    line_words_core(list, storage_list)
  end

  defp line_words_core(list, storage_list) do
    if Enum.count(list) > 0 do
      en_alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        str_ls = String.graphemes(String.downcase(List.first(list)))
        str_ls_len = Enum.count(str_ls)
        if Enum.count(Enum.dedup(str_ls)) == str_ls_len and Enum.all?(str_ls, fn(x) -> x in en_alphabet end) do
          storage_list = [List.first(list) | storage_list]
          list = List.delete_at(list, 0)
          line_words_core(list, storage_list)
        else
          list = List.delete_at(list, 0)
          line_words_core(list, storage_list)
        end
      else
        storage_list
      end
  end

  @doc"""
  Function `encode/2` with given text and shift, will return encrypted text by Caesar cypher.
  ## Example
  iex> ListCustom.encode(("lorem", 3))
  "oruph"
  """
  def encode(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map( fn char -> char < 97 || 97 + rem( char - 71 + shift, 26 ) end )
    |> to_string()
  end

  @doc"""
  Function `decode/2` with given cypher text and same shift, will return original message by Caesar cypher.
  ## Example
  iex> ListCustom.decode(("oruph", 3))
  "lorem"
  """
  def decode(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map( fn char -> char < 97 || 97 + rem( char - 71 - shift, 26 ) end )
    |> to_string()
  end

  def letters_combinations(""), do: [""]

  @doc"""
  Function `letters_combinations/1` with given a string of digits from 2 to 9, would return all
  possible letter combinations that the number could represent.
  ## Example
  iex> ListCustom.letters_combinations(("23"))
  ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]
  """
  def letters_combinations(<<key::binary-1, value::binary>>) do
    for char <- @dict[key], tail <- letters_combinations(value), do: char <> tail
  end

  @doc"""
  Function `group_anagrams/1` with given an array of strings, would group the anagrams
  together.
  ## Example
  iex> ListCustom.group_anagrams((["eat" , "tea" , "tan" , "ate" , "nat" , "bat"]))
  %{"abt" => ["bat"], "aet" => ["eat", "tea", "ate"], "ant" => ["tan", "nat"]}
  """
  def group_anagrams(strings) do
    Enum.group_by(strings, &String.split(&1, "") |> Enum.sort |> List.to_string)
  end

  @doc"""
  Function `longest_common_prefix/1` finds the longest common prefix string amongst a list of strings.
  ## Example
  iex> ListCustom.longest_common_prefix((["flower", "flow", "flight"]))
  "fl"
  """
  def longest_common_prefix(strings_array) do
    size = Enum.count(strings_array)
    case size do
      0 -> ""
      1 -> List.first(strings_array)
      _ -> strings_array = Enum.sort(strings_array)
      min_len = Enum.min([String.length(List.first(strings_array)), String.length(List.last(strings_array))])
      counter = 0
      longest_common_prefix_core(min_len, counter, strings_array)
    end


  end

  defp longest_common_prefix_core(min_len, counter, strings_array) do
    if min_len > counter and String.at(List.first(strings_array), counter) == String.at(List.last(strings_array), counter) do
      longest_common_prefix_core(min_len, counter + 1, strings_array)
    else
      String.slice(List.first(strings_array), 0, counter)
    end
  end

  @doc"""
  Function `to_roman/1` returns roman representation of given number in range 1...3999
  ## Example
  iex> ListCustom.to_roman(13)
  "XIII"
  """
  def to_roman(integer), do: to_roman_core(integer, "")
  defp to_roman_core(0, str_roman), do: str_roman
  defp to_roman_core(integer, str_roman) do
    case integer do
      integer when integer >= 1000 -> to_roman_core(integer - 1000, str_roman <> "M")
      integer  when integer >= 900 ->  to_roman_core(integer - 900, str_roman <> "CM")
      integer  when integer >= 500 ->  to_roman_core(integer-500, str_roman <> "D")
      integer  when integer >= 400 ->  to_roman_core(integer-400, str_roman <> "CD")
      integer  when integer >= 100 ->  to_roman_core(integer-100, str_roman <> "C")
      integer  when integer >= 90 ->  to_roman_core(integer-90, str_roman <> "XC")
      integer  when integer >= 50 ->  to_roman_core(integer-50, str_roman <> "L")
      integer  when integer >= 40 ->  to_roman_core(integer-40, str_roman <> "XL")
      integer  when integer >= 10 ->  to_roman_core(integer-10, str_roman <> "X")
      integer  when integer >= 9 ->  to_roman_core(integer-9, str_roman <> "IX")
      integer  when integer >= 5 ->  to_roman_core(integer-5, str_roman <> "V")
      integer  when integer >= 4 ->  to_roman_core(integer-4, str_roman <> "IV")
      integer  when integer >= 1 ->  to_roman_core(integer-1, str_roman <> "I")
      _ -> "Error input, input should be in range 1..3999"
    end
  end

  @doc"""
  Function `factorize/1` returns prime factorization of given number
  ## Example
  iex> ListCustom.factorize(13)
  [13]
  iex> ListCustom.factorize(42)
  [7, 3, 2]
  """
  def factorize(n, i \\ 2, fact_list \\ []) do
    if n == 1 do
      fact_list
    else
      if rem(n, i) == 0 do
        fact_list = [String.to_integer(Integer.to_string(i)) | fact_list]
        factorize(div(n, i), i + 1, fact_list)
      else
        factorize(n, i + 1, fact_list)
      end
    end
  end

end
