defmodule ChoirWeb.PageControllerTest do
  use ChoirWeb.ConnCase
  alias Choir.Users.User

  setup_all do
    # Not entirely sure why we need to do this, but following advice from here https://elixirforum.com/t/using-setup-all-with-database/8865/4
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Choir.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Choir.Repo, :auto)

    changeset =
      User.changeset(%User{}, %{
        email: "someone-#{Ecto.UUID.generate()}@email.com",
        password: "password",
        first_name: "Thom",
        last_name: "Yorke"
      })

    {:ok, existing_user} = Choir.Repo.insert(changeset)
    {:ok, existing_user: existing_user}
  end

  describe "the index should just return the SPA" do
    test "GET /", %{conn: conn} do
      conn = get(conn, "/")
      assert conn.status == 200
    end
  end

  describe "login flow" do
    test "we can successfully log in", %{conn: conn, existing_user: existing_user} do
      conn =
        post(conn, "/api/log_in", email: existing_user.email, password: existing_user.password)

      assert conn.status == 200
      assert(get_session(conn, :user) == existing_user.uid)
    end

    test "we fail logging in for invalid email/password combos", %{
      conn: conn,
      existing_user: existing_user
    } do
      conn = post(conn, "/api/log_in", email: existing_user.email, password: "wrong password")

      assert conn.status == 400
    end

    test "we fail logging in for nonexistent users", %{conn: conn} do
      conn =
        post(conn, "/api/log_in", email: "user that does not exist", password: "wrong password")

      assert conn.status == 400
    end
  end

  describe "signin flow" do
    test "we can successfully sign up", %{conn: conn} do
      email = "someone-#{Ecto.UUID.generate()}@email.com"

      conn =
        post(conn, "/api/sign_up", %{
          first_name: "Julius",
          last_name: "Alexander",
          email: email,
          password: "password"
        })

      assert conn.status == 200
      user = Choir.Repo.get_by(User, email: email)
      assert(get_session(conn, :user) == user.uid)
    end

    test "we fail signing up for incomplete data", %{conn: conn} do
      email = "someone-#{Ecto.UUID.generate()}@email.com"

      conn =
        post(conn, "/api/sign_up", %{first_name: "Julius", last_name: "Alexander", email: email})

      assert conn.status == 400
      assert nil == Choir.Repo.get_by(User, email: email)
    end

    test "we fail signing up for a duplicate email", %{conn: conn, existing_user: existing_user} do
      conn =
        post(conn, "/api/sign_up", %{
          first_name: "Julius",
          last_name: "Alexander",
          email: existing_user.email,
          password: "password"
        })

      assert conn.status == 409
    end
  end
end
