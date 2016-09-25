defmodule Choir.PageControllerTest do
  use Choir.ConnCase


  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "choir"
  end
end
