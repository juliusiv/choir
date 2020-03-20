defmodule ChoirWeb.AuthTestHelpers do
  use Phoenix.ConnTest
  alias Choir.{Accounts, Sessions}

  def add_user(email) do
    user = %{email: email, password: "reallyHard2gue$$", first_name: "Loolo", last_name: "Poop"}
    {:ok, user} = Accounts.create_user(user)
    user
  end

  def add_session(conn, user) do
    {:ok, %{id: session_id}} = Sessions.create_session(%{user_id: user.id})

    conn
    |> put_session(:phauxth_session_id, session_id)
    |> configure_session(renew: true)
  end
end
