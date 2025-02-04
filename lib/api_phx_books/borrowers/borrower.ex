defmodule ApiPhxBooks.Borrowers.Borrower do
  use Ecto.Schema
  alias ApiPhxBooks.OrderHistories.OrderHistory
  import Ecto.Changeset

  schema "borrowers" do
    field :name, :string
    field :email, :string
    has_many(:order_histories, OrderHistory)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(borrowers, attrs) do
    borrowers
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end
end
