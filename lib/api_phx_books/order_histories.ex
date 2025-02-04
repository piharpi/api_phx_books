defmodule ApiPhxBooks.OrderHistories do
  @moduledoc """
  The OrderHistories context.
  """

  import Ecto.Query, warn: false
  alias ApiPhxBooks.Repo

  alias ApiPhxBooks.OrderHistories.OrderHistory
  alias ApiPhxBooks.Books.Book

  @spec borrow_book(any(), any(), any()) :: any()
  def borrow_book(borrower_id, book_id, due_date) do
    book = Repo.get!(Book, book_id)

    existing_order =
      OrderHistory
      |> where([o], o.book_id == ^book_id and is_nil(o.returned_date) and o.status == :borrowed)
      |> Repo.one()

    if existing_order do
      {:error, :book_already_borrowed}
    else
      if book.available_copies > 0 do
        Repo.transaction(fn ->
          order =
            %OrderHistory{}
            |> OrderHistory.changeset(%{
              borrower_id: borrower_id,
              book_id: book_id,
              due_date: due_date,
              borrowed_date: DateTime.utc_now(),
              status: "borrowed"
            })
            |> Repo.insert!()

          book
          |> Book.copies_changeset(%{available_copies: book.available_copies - 1})
          |> Repo.update!()

          order
        end)
      else
        {:error, :no_available_copies}
      end
    end
  end

  def get_order_history!(id), do: Repo.get!(OrderHistory, id)

  def list_order_histories, do: Repo.all(OrderHistory)

  def return_book(%OrderHistory{} = order) do
    book = Repo.get!(Book, order.book_id)
    returned_date = DateTime.utc_now()

    Repo.transaction(fn ->
      updated_order =
        order
        |> OrderHistory.changeset(%{
          returned_date: returned_date,
          status:
            if(
              Date.after?(
                returned_date,
                DateTime.to_date(order.due_date)
              ),
              do: "overdue",
              else: "returned"
            )
        })
        |> Repo.update!()

      book
      |> Book.copies_changeset(%{available_copies: book.available_copies + 1})
      |> Repo.update!()

      updated_order
    end)
  end
end
