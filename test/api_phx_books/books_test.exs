defmodule ApiPhxBooks.BooksTest do
  use ApiPhxBooks.DataCase

  alias ApiPhxBooks.Books

  describe "books" do
    alias ApiPhxBooks.Books.Book

    import ApiPhxBooks.BooksFixtures

    @invalid_attrs %{author: nil, ntitle: nil, isbn: nil, total_copies: nil, available_copies: nil, created_at: nil, updated_at: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Books.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Books.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{author: "some author", ntitle: "some ntitle", isbn: "some isbn", total_copies: 42, available_copies: 42, created_at: ~U[2025-02-02 03:19:00Z], updated_at: ~U[2025-02-02 03:19:00Z]}

      assert {:ok, %Book{} = book} = Books.create_book(valid_attrs)
      assert book.author == "some author"
      assert book.ntitle == "some ntitle"
      assert book.isbn == "some isbn"
      assert book.total_copies == 42
      assert book.available_copies == 42
      assert book.created_at == ~U[2025-02-02 03:19:00Z]
      assert book.updated_at == ~U[2025-02-02 03:19:00Z]
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Books.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{author: "some updated author", ntitle: "some updated ntitle", isbn: "some updated isbn", total_copies: 43, available_copies: 43, created_at: ~U[2025-02-03 03:19:00Z], updated_at: ~U[2025-02-03 03:19:00Z]}

      assert {:ok, %Book{} = book} = Books.update_book(book, update_attrs)
      assert book.author == "some updated author"
      assert book.ntitle == "some updated ntitle"
      assert book.isbn == "some updated isbn"
      assert book.total_copies == 43
      assert book.available_copies == 43
      assert book.created_at == ~U[2025-02-03 03:19:00Z]
      assert book.updated_at == ~U[2025-02-03 03:19:00Z]
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Books.update_book(book, @invalid_attrs)
      assert book == Books.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Books.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Books.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Books.change_book(book)
    end
  end
end
