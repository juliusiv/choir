defmodule ChoirWeb.SessionController do
  use ChoirWeb, :controller

  import ChoirWeb.Authorize

  alias Phauxth.Login
  alias Choir.{Sessions, Sessions.Session}

  # plug :guest_check when action in [:create]

  def create(conn, %{"session" => params}) do
    case Login.verify(params) do
      {:ok, user} ->
        conn
        |> add_session(user)
        |> json(%{})

      {:error, _message} ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: ["Incorrect email/password combination"]})
    end
  end

  def delete(%Plug.Conn{assigns: %{current_user: %{id: user_id}}} = conn, _params) do
    session_id = conn |> get_session(:phauxth_session_id)

    case Sessions.get_session(session_id) do
      %Session{user_id: ^user_id} = session ->
        Sessions.delete_session(session)

        conn
        |> delete_session(:phauxth_session_id)
        |> json(%{})

      _ ->
        conn
        |> json(%{})
    end
  end

  def add_session(conn, user) do
    {:ok, %{id: session_id}} = Sessions.create_session(%{user_id: user.id})

    conn
    |> delete_session(:request_path)
    |> put_session(:phauxth_session_id, session_id)
    |> configure_session(renew: true)
  end
end
