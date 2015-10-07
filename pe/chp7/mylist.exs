defmodule MyList do
  def len([]),          do: 0
  def len([ _x | xs ]), do: 1 + len(xs)

  def square([]),         do: []
  def square([ x | xs ]), do: [ x*x | square(xs) ]

  def add_1([]),         do: []
  def add_1([ x | xs ]), do: [ x+1 | add_1(xs) ]

  def map([], _func),        do: []
  def map([ x | xs ], func), do: [ func.(x) | map(xs, func) ]

  def sum(xs),                    do: do_sum(xs, 0)
  defp do_sum([], total),         do: total
  defp do_sum([ x | xs ], total), do: do_sum(xs, x + total)

  def reduce([], value, _),            do: value
  def reduce([ x | xs ], value, func), do: reduce(xs, func.(x, value), func)

  def swap([]),              do: []
  def swap([ a, b | tail ]), do: [ b, a | swap(tail) ]
  def swap([_]),             do: raise "Can't swap a list with an odd number of elements"
end
