defmodule ApiPhxBooks.BooksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ApiPhxBooks.Books` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        author: "some author",
        available_copies: 42,
        created_at: ~U[2025-02-02 03:19:00Z],
        isbn: "some isbn",
        ntitle: "some ntitle",
        total_copies: 42,
        updated_at: ~U[2025-02-02 03:19:00Z]
      })
      |> ApiPhxBooks.Books.create_book()

    book
  end
end
