defmodule ApiPhxBooks.OrderHistories.OrderHistory do
  use Ecto.Schema
  import Ecto.Changeset

  @status_values [:borrowed, :overdue, :returned]

  schema "order_histories" do
    field :status, Ecto.Enum, values: @status_values
    field :borrowed_date, :utc_datetime
    field :due_date, :utc_datetime
    field :returned_date, :utc_datetime
    belongs_to :borrower, ApiPhxBooks.Borrowers.Borrower
    belongs_to :book, ApiPhxBooks.Books.Book

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order_history, attrs) do
    order_history
    |> cast(attrs, [:borrowed_date, :due_date, :returned_date, :borrower_id, :book_id, :status])
    |> validate_required([:borrowed_date, :borrower_id, :book_id])
    |> validate_inclusion(:status, @status_values,
      message: "must be one of: active, inactive, pending"
    )
  end
end
