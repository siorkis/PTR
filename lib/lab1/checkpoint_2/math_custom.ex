defmodule MathCustom do

  @doc"""
  Function `is_prime/1` check if provided number is prime and return true or false.
  ## Examples
  iex> MathCustom.is_prime(1)
  false
  iex> MathCustom.is_prime(2)
  true
  iex> MathCustom.is_prime(11)
  true
  iex> MathCustom.is_prime(20)
  false
  """

  def is_prime(1), do: false

  def is_prime(2), do: true

  def is_prime(number) do

    prime_part = 2**number-1
    prime = rem(prime_part, number)

    if prime == 1 do
      true
    else
      false
    end
  end

  @doc"""
  Function `cylinder_aria/2` calculate and return aria of cylinder by it's radius and heigh.
  ## Example
  iex> MathCustom.cylinder_aria(5, 10)
  471.24
  """
  def cylinder_aria(radius, heigh) do
    String.to_float(:erlang.float_to_binary(2*:math.pi()*radius*heigh + 2*:math.pi()*(radius**2), [decimals: 2]))
  end

  @doc"""
  Function `smallest_number/3` takes 3 digits as input and provide the smallest number of those combination.
  ## Example
  iex> MathCustom.smallest_number(4, 5, 3)
  345
  iex> MathCustom.smallest_number(0, 4, 3)
  304
  iex> MathCustom.smallest_number(0, 0, 3)
  300
  iex> MathCustom.smallest_number(0, 0, 0)
  0
  """
  def smallest_number(n1, n2, n3) do
    list = Enum.sort([n1, n2, n3], :asc)

    if List.first(list) == 0 do
      list = List.delete(list, 0)
      if Enum.member?(list, 0) do
        # smallest_number(List.first(list), List.last(list))
        String.to_integer(Integer.to_string(List.last(list))<>"0"<>"0")
      else
        Integer.undigits(List.insert_at(list, 1, 0))
      end
    else
      Integer.undigits(list)
    end
  end

  # def smallest_number(n1, n2) do
  #   list = Enum.sort([n1, n2], :asc)
  #   if List.first(list) == 0 do
  #     list = List.delete(list, 0)
  #     if Enum.member?(list, 0) do
  #       List.first(list)
  #     else
  #       List.last(list)
  #     end
  #   end
  # end


end
