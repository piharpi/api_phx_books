defmodule ApiPhxBooks.Borrowers do
  @moduledoc """
  The Borrowers context.
  """
  import Ecto.Query, warn: false
  alias ApiPhxBooks.Repo

  alias ApiPhxBooks.Borrowers.Borrower

  def list_borrowers do
    Repo.all(Borrower)
    |> Repo.preload(order_histories: [:book])
  end

  def get_borrower!(id) do
    Repo.get!(Borrower, id)
    |> Repo.preload(order_histories: [:book])
  end

  def create_borrower(attrs \\ %{}) do
    %Borrower{}
    |> Borrower.changeset(attrs)
    |> Repo.insert()
  end
end
