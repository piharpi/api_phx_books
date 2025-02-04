defmodule ApiPhxBooks.Repo.Migrations.AlterOrderHistoriesFieldName do
  use Ecto.Migration

  def change do
		rename table("order_histories"), :due_data, to: :due_date
  end
end
