defmodule Choir.PageController do
  use Choir.Web, :controller

  def index(conn, _params) do
    uuid = UUID.uuid1()
    IO.inspect uuid
    render conn, "index.html", uuid: uuid
  end
end
