defmodule ApiPhxBooksWeb.BorrowerJSON do
  alias ApiPhxBooks.Borrowers.Borrower

  def index(%{borrowers: borrowers}) do
    %{data: for(borrower <- borrowers, do: data(borrower))}
  end

  def show(%{borrower: borrower}), do: %{data: data(borrower)}

  def data(%Borrower{} = borrower) do
    %{
      id: borrower.id,
      name: borrower.name,
      email: borrower.email,
      orders_histories: Enum.map(borrower.order_histories, &render_order/1)
    }
  end

  defp render_order(order) do
    %{
      id: order.id,
      borrowed_date: order.borrowed_date,
      due_date: order.due_date,
      returned_date: order.returned_date,
      status: order.status,
      book_title: order.book.title,
      book_author: order.book.author,
      book_isbn: order.book.isbn
    }
  end
end
