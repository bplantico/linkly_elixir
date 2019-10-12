defmodule Linkly.Links.Url do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :long, :string
    field :short, :string

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:long, :short])
    |> validate_required([:long, :short])
    |> unique_constraint(:long)
    |> unique_constraint(:short)
  end
end
