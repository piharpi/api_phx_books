defmodule ApiPhxBooksWeb.BorrowerJSON do
	alias ApiPhxBooks.Borrowers.Borrower

	def index(%{borrowers: borrowers}) do
		%{data: for(borrower <- borrowers, do: data(borrower))}
	end

	def show(%{borrower: borrower}), do: %{data: data(borrower)}

	def data(%Borrower{} = borrower) do
		%{
			id: borrower.id,
			name: borrower.name,
			email: borrower.email
		}
	end
end
