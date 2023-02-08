Code.require_file("math_custom.ex")
Code.require_file("list_custom.ex")

IO.inspect(MathCustom.is_prime(1))
IO.inspect(MathCustom.is_prime(2))
IO.inspect(MathCustom.is_prime(10))
IO.inspect(MathCustom.is_prime(11))


IO.inspect(MathCustom.cylinder_aria(5, 10))

# list = ["1", "2", "3", "4"]
list = [1, 2, 3, 4]
IO.inspect(ListCustom.reverse_2(list))

list = [1 , 2 , 4 , 8 , 4 , 2]
IO.inspect(ListCustom.unique_sum(list))

IO.inspect(ListCustom.random_elem(list, 2))

IO.inspect(ListCustom.fibonacci(10))

dict = [mama: "mother", papa: "father"]
string = " mama is with papa "
IO.inspect(ListCustom.translator(dict, string))


IO.inspect(MathCustom.smallest_number(4, 5, 3))
IO.inspect(MathCustom.smallest_number(0, 3, 4))
IO.inspect(MathCustom.smallest_number(0, 0, 3))
IO.inspect(MathCustom.smallest_number(0, 0, 0))

IO.inspect(ListCustom.rotate_left([1 , 2 , 4 , 8 , 4] , 3))

IO.inspect(ListCustom.list_right_angle_triangles(20))

list = [1, 2, 2, 3, 3, 4, 5]
IO.inspect(ListCustom.remove_consecutive_duplicates(list))

list = ["Hello" ,"Alaska" ,"Dad" ,"Session"]
IO.inspect(ListCustom.line_words(list))

IO.inspect(ListCustom.encode("lorem", 3))
IO.inspect(ListCustom.decode("oruhp", 3))

IO.inspect(ListCustom.letters_combinations("23"))

IO.inspect(ListCustom.group_anagrams((["eat" , "tea" , "tan" , "ate" , "nat" , "bat"])))

list = ["flower", "flow", "flight"]
IO.inspect(ListCustom.longest_common_prefix(list))
list = ["alpha" , "beta" , "gamma"]
IO.inspect(ListCustom.longest_common_prefix(list))

IO.inspect(ListCustom.to_roman(13))

IO.inspect(ListCustom.factorize(42))

IO.inspect(ListCustom.longest_common_prefix(["flower" ,"flow" ,"flight"]))
