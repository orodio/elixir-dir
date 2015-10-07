defmodule EctoTest.Repo do
  use Ecto.Repo

  def url do
    "ecto:postgres:postgres@localhost/ecto_test"
  end

  def priv do
    app_dir(:ecto_test, "priv/repo")
  end

end
