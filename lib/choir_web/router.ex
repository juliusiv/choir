defmodule ChoirWeb.Router do
  use ChoirWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)

    plug(ChoirWeb.Plugs.Authenticate,
      unauthed_routes: ["/login", "/about", "/signup"],
      salt: "auth"
    )

    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
  end

  # Other scopes may use custom stacks.
  scope "/api", ChoirWeb do
    pipe_through(:api)

    post("/log_in", PageController, :log_in)
    post("/log_out", PageController, :log_out)
    post("/sign_up", PageController, :sign_up)
  end

  scope "/", ChoirWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/*anything", PageController, :index)
  end
end
