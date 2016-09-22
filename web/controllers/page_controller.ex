defmodule Choir.PageController do
  use Choir.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
