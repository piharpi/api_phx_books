defmodule ApiPhxBooks.OrderHistoriesTest do
  use ApiPhxBooks.DataCase

  alias ApiPhxBooks.OrderHistories

  describe "order_histories" do
    alias ApiPhxBooks.OrderHistories.OrderHistory

    import ApiPhxBooks.OrderHistoriesFixtures

    @invalid_attrs %{status: nil, borrowed_date: nil, due_data: nil, returned_date: nil}

    test "list_order_histories/0 returns all order_histories" do
      order_history = order_history_fixture()
      assert OrderHistories.list_order_histories() == [order_history]
    end

    test "get_order_history!/1 returns the order_history with given id" do
      order_history = order_history_fixture()
      assert OrderHistories.get_order_history!(order_history.id) == order_history
    end

    test "create_order_history/1 with valid data creates a order_history" do
      valid_attrs = %{status: "some status", borrowed_date: ~U[2025-02-03 14:52:00Z], due_data: ~U[2025-02-03 14:52:00Z], returned_date: ~U[2025-02-03 14:52:00Z]}

      assert {:ok, %OrderHistory{} = order_history} = OrderHistories.create_order_history(valid_attrs)
      assert order_history.status == "some status"
      assert order_history.borrowed_date == ~U[2025-02-03 14:52:00Z]
      assert order_history.due_data == ~U[2025-02-03 14:52:00Z]
      assert order_history.returned_date == ~U[2025-02-03 14:52:00Z]
    end

    test "create_order_history/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OrderHistories.create_order_history(@invalid_attrs)
    end

    test "update_order_history/2 with valid data updates the order_history" do
      order_history = order_history_fixture()
      update_attrs = %{status: "some updated status", borrowed_date: ~U[2025-02-04 14:52:00Z], due_data: ~U[2025-02-04 14:52:00Z], returned_date: ~U[2025-02-04 14:52:00Z]}

      assert {:ok, %OrderHistory{} = order_history} = OrderHistories.update_order_history(order_history, update_attrs)
      assert order_history.status == "some updated status"
      assert order_history.borrowed_date == ~U[2025-02-04 14:52:00Z]
      assert order_history.due_data == ~U[2025-02-04 14:52:00Z]
      assert order_history.returned_date == ~U[2025-02-04 14:52:00Z]
    end

    test "update_order_history/2 with invalid data returns error changeset" do
      order_history = order_history_fixture()
      assert {:error, %Ecto.Changeset{}} = OrderHistories.update_order_history(order_history, @invalid_attrs)
      assert order_history == OrderHistories.get_order_history!(order_history.id)
    end

    test "delete_order_history/1 deletes the order_history" do
      order_history = order_history_fixture()
      assert {:ok, %OrderHistory{}} = OrderHistories.delete_order_history(order_history)
      assert_raise Ecto.NoResultsError, fn -> OrderHistories.get_order_history!(order_history.id) end
    end

    test "change_order_history/1 returns a order_history changeset" do
      order_history = order_history_fixture()
      assert %Ecto.Changeset{} = OrderHistories.change_order_history(order_history)
    end
  end
end
