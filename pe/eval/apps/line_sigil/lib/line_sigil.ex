defmodule LineSigil do
  def sigil_l lines, _ do
    lines
      |> String.rstrip
      |> String.split("\n")
  end
end
