defmodule ApiPhxBooks.Repo.Migrations.CreateBorrowers do
  use Ecto.Migration

  def change do
    create table(:borrowers) do
      add :name, :string
      add :email, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:borrowers, [:email])
  end
end
