defmodule ApiPhxBooks.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :author, :string
    field :title, :string
    field :isbn, :string
    field :total_copies, :integer
    field :available_copies, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :isbn, :total_copies, :available_copies])
    |> validate_required([:title, :author, :isbn, :total_copies, :available_copies])
  end
end
