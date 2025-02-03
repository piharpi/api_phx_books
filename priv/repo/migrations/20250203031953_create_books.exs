defmodule ApiPhxBooks.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :ntitle, :string
      add :author, :string
      add :isbn, :string
      add :total_copies, :integer
      add :available_copies, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
