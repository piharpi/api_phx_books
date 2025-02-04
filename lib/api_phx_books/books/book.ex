defmodule ApiPhxBooks.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiPhxBooks.OrderHistories.OrderHistory

  schema "books" do
    field :author, :string
    field :title, :string
    field :isbn, :string
    field :total_copies, :integer
    field :available_copies, :integer
    field :deleted_at, :utc_datetime
    has_many(:order_histories, OrderHistory)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def new_changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :isbn, :total_copies, :available_copies])
    |> validate_required([:title, :author, :isbn, :total_copies, :available_copies])
    |> unique_constraint(:isbn)
    |> validate_number(:total_copies, greater_than: 0)
    |> validate_number(:available_copies, greater_than: 0)
  end

  def update_changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :isbn])
    |> validate_required([:title, :author, :isbn])
    |> unique_constraint(:isbn)
  end

  def copies_changeset(book, attrs) do
    book
    |> cast(attrs, [:available_copies])
    |> validate_required([:available_copies])
    |> validate_number(:available_copies, greater_than_or_equal_to: 0)
  end

  def soft_delete_changeset(book) do
    book
    |> change(deleted_at: DateTime.utc_now() |> DateTime.truncate(:second))
  end
end
