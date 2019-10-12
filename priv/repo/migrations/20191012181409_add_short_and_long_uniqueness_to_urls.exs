defmodule Linkly.Repo.Migrations.AddShortAndLongUniquenessToUrls do
  use Ecto.Migration

  def change do
    create unique_index(:urls, [:short])
    create unique_index(:urls, [:long])
  end
end
