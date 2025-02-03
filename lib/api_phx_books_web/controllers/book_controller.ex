defmodule ApiPhxBooksWeb.BookController do
  use ApiPhxBooksWeb, :controller

  alias ApiPhxBooks.Books
  alias ApiPhxBooks.Books.Book

  action_fallback ApiPhxBooksWeb.FallbackController

  def index(conn, _params) do
    books = Books.list_books()
    render(conn, :index, books: books)
  end

  @spec create(any(), map()) :: any()
  def create(conn, %{"book" => book_params}) do
    with {:ok, %Book{} = book} <- Books.create_book(book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/books/#{book}")
      |> render(:show, book: book)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Books.get_book!(id)
    render(conn, :show, book: book)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Books.get_book!(id)

    with {:ok, %Book{} = book} <- Books.update_book(book, book_params) do
      render(conn, :show, book: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Books.get_book!(id)

    with {:ok, %Book{}} <- Books.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end
end
