defmodule ApiPhxBooksWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ApiPhxBooksWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: ApiPhxBooksWeb.ErrorHTML, json: ApiPhxBooksWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, %Ecto.Changeset{}}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: ApiPhxBooksWeb.ErrorJSON)
    |> render(:"422")
  end

  def call(conn, {:error, :no_available_copies}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: ApiPhxBooksWeb.ErrorJSON)
    |> render(:"422")
  end

  def call(conn, {:error, :book_already_borrowed}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: ApiPhxBooksWeb.ErrorJSON)
    |> render(:"422")
  end

  def call(conn, {:error, :book_already_returned}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: ApiPhxBooksWeb.ErrorJSON)
    |> render(:"422")
  end
end
