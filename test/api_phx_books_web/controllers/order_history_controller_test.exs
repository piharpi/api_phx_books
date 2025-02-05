defmodule ApiPhxBooksWeb.OrderHistoryControllerTest do
  use ApiPhxBooksWeb.ConnCase

  import ApiPhxBooks.OrderHistoriesFixtures

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all order_histories", %{conn: conn} do
      order = order_history_fixture()

      conn = get(conn, ~p"/api/orders")

      assert [
               %{
                 "id" => order.id,
                 "status" => Atom.to_string(order.status),
                 "due_date" => DateTime.to_iso8601(order.due_date),
                 "returned_date" => order.returned_date,
                 "borrowed_date" => DateTime.to_iso8601(order.borrowed_date)
               }
             ] == json_response(conn, 200)["data"]
    end
  end

  describe "create order_history" do
    test "order borrowed book", %{conn: conn} do
      borrower = borrower_fixture()
      book = book_fixture()

      borrowed = %{
        "due_date" => DateTime.utc_now() |> DateTime.add(1, :hour),
        "book_id" => book.id,
        "borrower_id" => borrower.id
      }

      conn = post(conn, ~p"/api/orders/borrow", borrowed)

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/orders/#{id}")

      assert %{
               "id" => ^id,
               "returned_date" => nil,
               "status" => "borrowed"
             } = json_response(conn, 200)["data"]
    end
  end

  describe "update order_history" do
    test "order returned book", %{conn: conn} do
      borrowed = order_history_fixture()

      conn = post(conn, ~p"/api/orders/return/#{borrowed.id}", nil)

      assert %{"id" => id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/orders/#{id}")

      %{
        "status" => status,
        "returned_date" => returned_date
      } =
        json_response(conn, 200)["data"]

      assert id == borrowed.id
      assert status == "returned"
      assert returned_date != nil
    end
  end
end
