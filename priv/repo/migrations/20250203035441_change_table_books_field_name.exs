defmodule ApiPhxBooks.Repo.Migrations.ChangeTableBooksFieldName do
  use Ecto.Migration

  def change do
    rename table("books"), :ntitle, to: :title
  end
end
