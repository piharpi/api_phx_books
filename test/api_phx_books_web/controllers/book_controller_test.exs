defmodule ApiPhxBooksWeb.BookControllerTest do
  use ApiPhxBooksWeb.ConnCase

  import ApiPhxBooks.BooksFixtures

  alias ApiPhxBooks.Books.Book

  @create_attrs %{
    author: "some author",
    title: "some title",
    isbn: "some isbn",
    total_copies: 42,
    available_copies: 42
  }
  @update_attrs %{
    author: "some updated author",
    title: "some updated title",
    isbn: "some updated isbn",
    total_copies: 43,
    available_copies: 43
  }
  @invalid_attrs %{author: nil, title: nil, isbn: nil, total_copies: nil, available_copies: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all books", %{conn: conn} do
      conn = get(conn, ~p"/api/books")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create book" do
    test "renders book when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/books", book: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/books/#{id}")

      assert %{
               "id" => ^id,
               "author" => "some author",
               "available_copies" => 42,
               "isbn" => "some isbn",
               "title" => "some title",
               "total_copies" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/books", book: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
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
               "author" => "some updated author",
               "available_copies" => 43,
               "isbn" => "some updated isbn",
               "title" => "some updated title",
               "total_copies" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, book: book} do
      conn = put(conn, ~p"/api/books/#{book}", book: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
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
