defmodule ApiPhxBooks.Repo do
  use Ecto.Repo,
    otp_app: :api_phx_books,
    adapter: Ecto.Adapters.Postgres
end
