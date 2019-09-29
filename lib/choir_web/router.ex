defmodule ChoirWeb.Router do
  use ChoirWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  # Other scopes may use custom stacks.
  scope "/api", ChoirWeb do
    pipe_through(:api)

    post("/log_in", PageController, :log_in)
    post("/sign_up", PageController, :sign_up)
  end

  # We put this last catch-all at the end so we don't conflict with our SPA routes.
  scope "/", ChoirWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/*anything", PageController, :index)
  end
end
