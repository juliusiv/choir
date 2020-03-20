defmodule ChoirWeb.Router do
  use ChoirWeb, :router

  def user_check(%Plug.Conn{assigns: %{current_user: nil}} = conn, opts) do
    unauthed_routes = Keyword.get(opts, :unauthed_routes, [])

    if conn.request_path in unauthed_routes do
      conn
    else
      need_login(conn)
    end
  end

  def user_check(conn, _opts), do: conn

  defp need_login(conn) do
    conn
    |> put_session(:request_path, current_path(conn))
    |> redirect(to: "/login")
    |> halt()
  end

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(Phauxth.Authenticate)
    plug(:user_check, unauthed_routes: ["/login", "/signup", "/"])
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
    plug(Phauxth.Authenticate)
  end

  scope "/api", ChoirWeb do
    pipe_through(:api)

    get("/users", UserController, :show)
    post("/sign_up", UserController, :create)

    post("/log_in", SessionController, :create)
    delete("/log_out", SessionController, :delete)
  end

  scope "/", ChoirWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/*anything", PageController, :index)
  end
end
