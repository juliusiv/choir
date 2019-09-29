defmodule ChoirWeb.Plugs.Authenticate do
  import Plug.Conn

  def init(options), do: options

  # def call(conn, options) when Enum.member?(options[:unauthed_routes], conn.request_path) do
  def call(conn, options) do
    if Enum.member?(options[:unauthed_routes], conn.request_path) do
      conn
    else
      token = get_session(conn, :token)

      case Phoenix.Token.verify(conn, options[:salt], token, max_age: :infinity) do
        {:error, _} ->
          conn |> Phoenix.Controller.redirect(to: "/login") |> halt()

        _ ->
          conn
      end
    end
  end
end
