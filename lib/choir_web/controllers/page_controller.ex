defmodule ChoirWeb.PageController do
  use ChoirWeb, :controller

  # The main page is where users hear the music for now. Once we're here, everything else will be handled
  # in the SPA.
  # TODO: This should probably be a signup/in page that will redirect to /listen (or something)
  # if they have an active session.
  def index(conn, _params) do
    uuid = UUID.uuid1()
    IO.inspect uuid
    render conn, "index.html", uuid: uuid, page: "index"
  end

  # The login page is served completely separate from the rest of the app, so we have more control over it and it's
  # more secure (no JS dependencies, third party libs, etc.)
  def login(conn, _params) do
    render conn, "login.html", uuid: "_login", page: "login"
  end

  def log_in(conn, _params) do
    IO.inspect _params
  end

  # The rehearsal space is where users can tweak their own values to create
  # music they like (which is also helpful for debugging the generative synthesis.)
  def rehearse(conn, _params) do
    render conn, "rehearse.html", uuid: "_rehearsing", page: "rehearse"
  end
end
