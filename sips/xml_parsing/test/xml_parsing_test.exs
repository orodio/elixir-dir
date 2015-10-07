require Record

defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
defrecord :xmlTest, Record.extract(:xmlText, from: "xmerl/include/xmerl.hrl")

defmodule XmlParsingTest do
  use ExUnit.Case

  def sample_xml do
    """
    <html>
      <head>
        <title>XML Parsing</title>
      </head>
      <body>
        <p>Neato</p>
        <ul>
          <li>First</li>
          <li>Second</li>
        </ul>
      </body>
    </html>
    """
  end

  test "parsing the title out" do
    { xml, _rest } = :xmerl_scan.string(:erlang.bitstring_to_list(sample_xml))
    title = :xmerl_xpath.string('/html/head/title', xml)

    assert title == "XML Parsing"
  end

  # test "" do
  # end
end
