defmodule ApiPhxBooksWeb.BorrowerController do
  use ApiPhxBooksWeb, :controller

  alias ApiPhxBooks.Borrowers

  action_fallback ApiPhxBooksWeb.FallbackController

  def index(conn, _params) do
    borrowers = Borrowers.list_borrowers()
    render(conn, :index, borrowers: borrowers)
  end

  def show(conn, %{"id" => id}) do
    borrower = Borrowers.get_borrower!(id)
    render(conn, :show, borrower: borrower)
  end
end
