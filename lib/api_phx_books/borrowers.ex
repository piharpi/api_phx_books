defmodule ApiPhxBooks.Borrowers do
	@moduledoc """
	The Borrowers context.
	"""
	import Ecto.Query, warn: false
	alias ApiPhxBooks.Repo

	alias ApiPhxBooks.Borrowers.Borrower

	def list_borrowers, do: Repo.all(Borrower)

	def get_borrower!(id), do: Repo.get!(Borrower, id)
end
