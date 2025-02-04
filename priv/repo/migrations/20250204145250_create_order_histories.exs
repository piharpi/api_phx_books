defmodule ApiPhxBooks.Repo.Migrations.CreateOrderHistories do
  use Ecto.Migration

  def change do
    create table(:order_histories) do
      add :borrowed_date, :utc_datetime
      add :due_data, :utc_datetime
      add :returned_date, :utc_datetime
      add :status, :string
      add :borrower_id, references(:borrowers, on_delete: :nothing)
      add :book_id, references(:books, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:order_histories, [:borrower_id])
    create index(:order_histories, [:book_id])
  end
end
