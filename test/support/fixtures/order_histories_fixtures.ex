defmodule ApiPhxBooks.OrderHistoriesFixtures do
  alias ApiPhxBooks.{Books, Borrowers, OrderHistories}

  @valid_book_attrs %{
    author: "Agus",
    title: "Buku Baca Harian",
    isbn: "9933000222",
    total_copies: 3,
    available_copies: 3
  }

  @valid_borrower_attrs %{
    name: "John Doe",
    email: "john.doe@example.com"
  }

  @spec book_fixture(any()) :: any()
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(@valid_book_attrs)
      |> Books.create_book()

    book
  end

  @spec borrower_fixture(any()) :: any()
  def borrower_fixture(attrs \\ %{}) do
    {:ok, borrower} =
      attrs
      |> Enum.into(@valid_borrower_attrs)
      |> Borrowers.create_borrower()

    borrower
  end

  @spec order_history_fixture(nil | maybe_improper_list() | map()) :: any()
  def order_history_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        borrower_id: attrs[:borrower_id] || borrower_fixture().id,
        book_id: attrs[:book_id] || book_fixture().id,
        borrowed_date: DateTime.utc_now(),
        due_date: DateTime.utc_now() |> DateTime.add(1, :hour),
        returned_date: nil,
        status: :borrowed
      })
      |> OrderHistories.create_order_histories()

    order
  end
end
