defmodule ApiPhxBooks.BooksFixtures do
  alias ApiPhxBooks.Books

  @valid_attrs %{
    title: "Buku Cerita Agus",
    author: "Agus",
    isbn: "9780743273565",
    available_copies: 3,
    total_copies: 3
  }

  @spec book_fixture(any()) :: any()
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Books.create_book()

    book
  end
end
