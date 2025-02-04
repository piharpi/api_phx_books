defmodule ApiPhxBooksWeb.OrderHistoryController do
  use ApiPhxBooksWeb, :controller

  alias ApiPhxBooks.OrderHistories
  alias ApiPhxBooks.OrderHistories.OrderHistory

  action_fallback ApiPhxBooksWeb.FallbackController

  def borrow(conn, %{
        "borrower_id" => borrower_id,
        "book_id" => book_id,
        "due_date" => due_date
      }) do
    with {:ok, %OrderHistory{} = order} <-
           OrderHistories.borrow_book(borrower_id, book_id, due_date) do
      conn
      |> put_status(:created)
      |> render(:show, order_history: order)
    end
  end

  def return(conn, %{"id" => id}) do
    order = OrderHistories.get_order_history!(id)

    with {:ok, %OrderHistory{} = updated_order} <- OrderHistories.return_book(order) do
      render(conn, :show, order_history: updated_order)
    end
  end

  def index(conn, _params) do
    order_histories = OrderHistories.list_order_histories()
    render(conn, :index, order_histories: order_histories)
  end
end
