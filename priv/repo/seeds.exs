# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ApiPhxBooks.Repo.insert!(%ApiPhxBooks.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ApiPhxBooks.Repo
alias ApiPhxBooks.Borrowers.Borrower

borrowers = [
  %{name: "John Doe", email: "john.doe@example.com"},
  %{name: "Jane Smith", email: "jane.smith@example.com"},
  %{name: "Alice Johnson", email: "alice.johnson@example.com"}
]

Repo.delete_all(Borrower)

Enum.each(borrowers, fn borrower ->
  Repo.insert!(%Borrower{} |> Borrower.changeset(borrower))
end)

IO.puts("Seed borrowers data successfully")
