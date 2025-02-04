defmodule ApiPhxBooks.Repo.Migrations.AddDeletedAtToBooks do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :deleted_at, :utc_datetime
    end

    create index(:books, [:deleted_at])
  end
end
