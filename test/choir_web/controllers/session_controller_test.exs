defmodule ChoirWeb.SessionControllerTest do
  use ChoirWeb.ConnCase

  import ChoirWeb.AuthTestHelpers

  @create_attrs %{email: "robin@example.com", password: "reallyHard2gue$$"}
  @invalid_attrs %{email: "robin@example.com", password: "cannotGue$$it"}

  setup %{conn: conn} do
    conn = conn |> bypass_through(ChoirWeb.Router, [:browser]) |> get("/")
    user = add_user("robin@example.com")
    {:ok, %{conn: conn, user: user}}
  end

  describe "create session" do
    test "login succeeds", %{conn: conn} do
      %{status: status} = post(conn, "/api/log_in", session: @create_attrs)
      assert status == 200
    end

    test "logged in users can be logged in again", %{conn: conn, user: _user} do
      %{resp_cookies: %{"_choir_key" => initial_session_key}} =
        post(conn, "/api/log_in", session: @create_attrs)

      conn = post(conn, "/api/log_in", session: @create_attrs)

      %{
        status: status,
        resp_cookies: %{"_choir_key" => new_session_key}
      } = post(conn, "/api/log_in", session: @create_attrs)

      assert status == 200
      assert initial_session_key != new_session_key
    end

    test "login fails for invalid password", %{conn: conn} do
      %{status: status} = post(conn, "/api/log_in", session: @invalid_attrs)
      assert status == 400
    end
  end

  describe "delete session" do
    test "logout succeeds and session is deleted", %{conn: conn, user: user} do
      conn = conn |> add_session(user) |> send_resp(:ok, "/")
      %{status: status} = delete(conn, "/api/log_out")
      assert status == 200
    end
  end
end
