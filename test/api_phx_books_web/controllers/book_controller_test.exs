defmodule ApiPhxBooksWeb.BookControllerTest do
  use ApiPhxBooksWeb.ConnCase

  import ApiPhxBooks.BooksFixtures

  alias ApiPhxBooks.Books.Book

  @create_attrs %{
    author: "Agus",
    title: "Buku Baca Harian",
    isbn: "9933000222",
    total_copies: 3,
    available_copies: 3
  }

  @update_attrs %{
    author: "Update Agus",
    title: "Update Buku Baca Harian",
    isbn: "11133000222",
    total_copies: 10,
    available_copies: 10
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all books", %{conn: conn} do
      book = book_fixture()

      conn = get(conn, ~p"/api/books")

      assert [
               %{
                 "id" => book.id,
                 "title" => book.title,
                 "author" => book.author,
                 "isbn" => book.isbn,
                 "available_copies" => book.available_copies,
                 "total_copies" => book.total_copies
               }
             ] == json_response(conn, 200)["data"]
    end
  end

  describe "create book" do
    test "renders book when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/books", book: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/books/#{id}")

      assert %{
               "id" => ^id,
               "title" => "Buku Baca Harian",
               "author" => "Agus",
               "available_copies" => 3,
               "isbn" => "9933000222",
               "total_copies" => 3
             } = json_response(conn, 200)["data"]
    end
  end

  describe "update book" do
    setup [:create_book]

    test "renders book when data is valid", %{conn: conn, book: %Book{id: id} = book} do
      conn = put(conn, ~p"/api/books/#{book}", book: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/books/#{id}")

      assert %{
               "id" => ^id,
               "author" => "Update Agus",
               "available_copies" => 3,
               "isbn" => "11133000222",
               "title" => "Update Buku Baca Harian",
               "total_copies" => 3
             } = json_response(conn, 200)["data"]
    end
  end

  describe "delete book" do
    setup [:create_book]

    test "deletes chosen book", %{conn: conn, book: book} do
      conn = delete(conn, ~p"/api/books/#{book}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/books/#{book}")
      end
    end
  end

  defp create_book(_) do
    book = book_fixture()
    %{book: book}
  end
end
