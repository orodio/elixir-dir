defmodule Frequency do
  def start_link do
    Agent.start_link &HashDict.new/0, name: __MODULE__
  end

  def add_word word do
    Agent.update __MODULE__, &update(&1, word)
  end

  def count_for word do
    Agent.get __MODULE__, &Dict.get(&1, word)
  end

  def words do
    Agent.get __MODULE__, &Dict.keys/1
  end

  def update dict, word do
    Dict.update dict, word, 1, &(&1 +1)
  end
end
