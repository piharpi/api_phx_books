defmodule ApiPhxBooksWeb.OrderHistoryJSON do
  alias ApiPhxBooks.OrderHistories.OrderHistory

  @doc """
  Renders a list of order_histories.
  """
  def index(%{order_histories: order_histories}) do
    %{data: for(order_history <- order_histories, do: data(order_history))}
  end

  @doc """
  Renders a single order_history.
  """
  def show(%{order_history: order_history}) do
    %{data: data(order_history)}
  end

  defp data(%OrderHistory{} = order_history) do
    %{
      id: order_history.id,
      borrowed_date: order_history.borrowed_date,
      due_date: order_history.due_date,
      returned_date: order_history.returned_date,
      status: order_history.status
    }
  end
end
