defmodule FarkovChain.Generator do
  def generate_words(dict, start, num) do
    generate_words(dict, start, num-1, [start])
  end

  def generate_words(_dict, _start, 0, words) do
    words |> Enum.reverse |> Enum.join(" ")
  end

  def generate_words(dict, start, num, words) do
    new_word = get_word(dict, start)
    generate_words(dict, new_word, num-1, [new_word | words])
  end

  def get_word(dictionary, start) do
    hd(FarkovChain.Dictionary.next(dictionary, start))
  end
end
