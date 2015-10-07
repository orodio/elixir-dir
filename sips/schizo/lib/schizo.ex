defmodule Schizo do
  @moduledoc """
    A nice module that lets you uppercase or unvowel every other word in a sentence.
  """

  @doc """
    Uppercases every other word in a sentence. Example:

    iex> Schizo.uppercase "you are silly lol"
    "you ARE silly LOL"
  """
  def uppercase string do
    xform_every_other_word string, &uppercaser/1
  end

  @doc """
    Unvowels every other word in a sentence. Example:

    iex> Schizo.unvowel "you are silly lol"
    "you r silly ll"
  """
  def unvowel string do
    xform_every_other_word string, &unvoweler/1
  end

  def xform_every_other_word string, xform do
    string
    |> String.split
    |> Stream.with_index
    |> Enum.map(xform)
    |> Enum.join(" ")
  end

  def uppercaser input do
    xformer input, &String.upcase/1
  end

  def unvoweler input do
    xformer input, fn word -> Regex.replace(~r([aeiou]), word, "") end
  end

  def xformer {word, index}, transformation do
    cond do
      rem(index, 2) == 0 -> word
      rem(index, 2) == 1 -> transformation.(word)
    end
  end
end
