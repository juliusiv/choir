defmodule Choir.PageController do
  use Choir.Web, :controller


  def index(conn, _params) do
    uuid = UUID.uuid1()
    IO.inspect uuid
    render conn, "index.html", uuid: uuid, page: "index"
  end

  def rehearse(conn, _params) do
    render conn, "rehearse.html", uuid: "_rehearsing", page: "rehearse"
  end
end
