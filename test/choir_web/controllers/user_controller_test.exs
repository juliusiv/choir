defmodule ChoirWeb.UserControllerTest do
  use ChoirWeb.ConnCase

  @create_attrs %{
    email: "bill@example.com",
    password: "hard2guess",
    first_name: "Andy",
    last_name: "Shauf"
  }
  @invalid_attrs %{email: nil}

  setup %{conn: conn} do
    conn = conn |> bypass_through(ChoirWeb.Router, [:browser]) |> get("/")
    {:ok, %{conn: conn}}
  end

  describe "get user info" do
    test "show logged in user's info", %{conn: conn} do
      conn = post(conn, "/api/sign_up", user: @create_attrs)

      data =
        conn
        |> get("/api/users")
        |> json_response(200)

      assert Map.take(data, ["email", "first_name", "last_name"]) == %{
               "email" => @create_attrs.email,
               "first_name" => @create_attrs.first_name,
               "last_name" => @create_attrs.last_name
             }
    end

    test "returns 401 when user not found", %{conn: conn} do
      %{status: status} = get(conn, "/api/users")

      assert status == 401
    end
  end

  describe "create user" do
    test "creates user when data is valid", %{conn: conn} do
      conn = post(conn, "/api/sign_up", user: @create_attrs)

      data = json_response(conn, 200)

      assert Map.take(data, ["email", "first_name", "last_name"]) == %{
               "email" => @create_attrs.email,
               "first_name" => @create_attrs.first_name,
               "last_name" => @create_attrs.last_name
             }
    end

    test "does not create user and renders errors when data is invalid", %{conn: conn} do
      %{status: status} = post(conn, "/api/sign_up", user: @invalid_attrs)
      assert status == 400
    end
  end
end
