defmodule ApiPhxBooks.Repo.Migrations.AlterBooksAddUniqueConstraint do
  use Ecto.Migration

  def change do
    create unique_index(:books, [:isbn])
  end
end
