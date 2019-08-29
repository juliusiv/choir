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

  scope "/", ChoirWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope "/login", ChoirWeb do
    pipe_through(:browser)

    get("/", PageController, :login)
    post("/", PageController, :log_in)
  end

  scope "/signup", ChoirWeb do
    pipe_through(:browser)

    get("/", PageController, :signup)
    post("/", PageController, :sign_up)
  end

  scope "/signup", ChoirWeb do
    pipe_through(:browser)

    get("/", PageController, :signup)
    post("/", PageController, :sign_up)
  end

  # Other scopes may use custom stacks.
  scope "/api", ChoirWeb do
    pipe_through(:api)
  end
end
