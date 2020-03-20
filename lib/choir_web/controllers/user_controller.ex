defmodule ChoirWeb.UserController do
  use ChoirWeb, :controller

  import ChoirWeb.Authorize
  import ChoirWeb.SessionController, only: [add_session: 2]

  alias Phauxth.Log
  alias Choir.{Accounts, Accounts.User}

  # the following plugs are defined in the controllers/authorize.ex file
  plug(:user_check when action in [:index, :show])
  plug(:id_check when action in [:edit, :update, :delete])

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        Log.info(%Log{user: user.id, message: "user created"})

        conn
        |> add_session(user)
        |> json(%{
          first_name: user.first_name,
          last_name: user.last_name,
          email: user.email,
          created_at: user.inserted_at
        })

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: ["Could not create user."]})
    end
  end

  def show(%Plug.Conn{assigns: %{current_user: current_user}} = conn, _params) do
    user = Accounts.get_user!(current_user.id)

    json(conn, %{
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      created_at: user.inserted_at
    })
  end
end
