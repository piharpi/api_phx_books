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

  defp create_order_history() do
    order = order_history_fixture()
    %{order: order}
  end

  # describe "create order_history" do
  #   test "renders order_history when data is valid", %{conn: conn} do
  #     conn = post(conn, ~p"/api/order_histories", order_history: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, ~p"/api/order_histories/#{id}")

  #     assert %{
  #              "id" => ^id,
  #              "borrowed_date" => "2025-02-03T14:52:00Z",
  #              "due_data" => "2025-02-03T14:52:00Z",
  #              "returned_date" => "2025-02-03T14:52:00Z",
  #              "status" => "some status"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, ~p"/api/order_histories", order_history: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update order_history" do
  #   setup [:create_order_history]

  #   test "renders order_history when data is valid", %{conn: conn, order_history: %OrderHistory{id: id} = order_history} do
  #     conn = put(conn, ~p"/api/order_histories/#{order_history}", order_history: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, ~p"/api/order_histories/#{id}")

  #     assert %{
  #              "id" => ^id,
  #              "borrowed_date" => "2025-02-04T14:52:00Z",
  #              "due_data" => "2025-02-04T14:52:00Z",
  #              "returned_date" => "2025-02-04T14:52:00Z",
  #              "status" => "some updated status"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, order_history: order_history} do
  #     conn = put(conn, ~p"/api/order_histories/#{order_history}", order_history: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete order_history" do
  #   setup [:create_order_history]

  #   test "deletes chosen order_history", %{conn: conn, order_history: order_history} do
  #     conn = delete(conn, ~p"/api/order_histories/#{order_history}")
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, ~p"/api/order_histories/#{order_history}")
  #     end
  #   end
  # end
end
