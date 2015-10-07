defmodule Unix do
  def ps_ax do
    """
  PID   TT  STAT      TIME COMMAND
  399   ??  S      0:15.31 com.apple.photostream-agent
21174   ??  Ss     0:00.09 postgres: checkpointer process
21175   ??  Ss     0:02.35 postgres: writer process
21176   ??  Ss     0:02.26 postgres: wal writer process
21177   ??  Ss     0:04.28 postgres: autovacuum launcher process
21178   ??  Ss     0:13.44 postgres: stats collector process
28180 s000  Ss     0:00.04 login -fp orodio
29080 s000  S+     0:00.31 vim
    """
  end

  def grep(input, match) do
    String.split(input, "\n")
    |> Enum.filter(fn(line) -> Regex.match?(match, line) end)
  end

  def awk(lines, column) do
    Enum.map(lines, fn(line) ->
      stripped = String.strip(line)
      |> Unix.regex_split(~r/ /)
      |> Enum.at(column-1)
    end)
  end

  def regex_split(lines, regex) do
    Regex.split(regex, lines, trim: true)
  end
end

defmodule PipeOperatorTest do
  use ExUnit.Case

  test "ps_ax outputs some processes" do
    output = """
  PID   TT  STAT      TIME COMMAND
  399   ??  S      0:15.31 com.apple.photostream-agent
21174   ??  Ss     0:00.09 postgres: checkpointer process
21175   ??  Ss     0:02.35 postgres: writer process
21176   ??  Ss     0:02.26 postgres: wal writer process
21177   ??  Ss     0:04.28 postgres: autovacuum launcher process
21178   ??  Ss     0:13.44 postgres: stats collector process
28180 s000  Ss     0:00.04 login -fp orodio
29080 s000  S+     0:00.31 vim
    """
    assert Unix.ps_ax == output
  end

  test "grep(lines, thing) returns lines that match 'thing'" do
    lines = """
    foo
    bar
    thing foo
    baz
    thing qux
    """
    assert Unix.grep(lines, ~r/thing/) == ["thing foo", "thing qux"]
  end

  test "awk(input, 1) splits on whitespace and return the first column" do
    input = ["foo bar", " baz    qux"]
    output = ["foo", "baz"]
    assert Unix.awk(input, 1) == output
  end

  test "the whole pipeline works" do
    output = Unix.ps_ax |> Unix.grep(~r/writer/) |> Unix.awk(1)
    assert output == ["21175", "21176"]
  end
end
