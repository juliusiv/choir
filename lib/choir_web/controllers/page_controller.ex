defmodule ChoirWeb.PageController do
  use ChoirWeb, :controller
  alias Choir.Users.User

  # The main page is where users hear the music for now. Once we're here, everything else will be handled
  # in the SPA.
  # TODO: This should probably be a signup/in page that will redirect to /listen (or something)
  # if they have an active session.
  def index(conn, _params) do
    render(conn, "index.html", uuid: Ecto.UUID.generate(), page: "index")
  end

  defp set_user_session(conn, user) do
    conn |> fetch_session |> put_session(:user, user.uid)
  end

  def log_in(conn, params) do
    user = Choir.Repo.get_by(User, email: params["email"])

    case user do
      nil ->
        json(put_status(conn, :bad_request), %{
          errors: ["Incorrect email/password combination"]
        })

      _ ->
        if not Bcrypt.verify_pass(params["password"], user.password_hash) do
          json(put_status(conn, :bad_request), %{
            errors: ["Incorrect email/password combination"]
          })
        else
          conn |> set_user_session(user) |> send_resp(:ok, "")
        end
    end
  end

  def sign_up(conn, params) do
    changeset = User.changeset(%User{}, params)

    case Choir.Repo.insert(changeset) do
      {:ok, user} ->
        conn |> set_user_session(user) |> send_resp(:ok, "")

      {:error, change} ->
        case change.errors do
          [email: _] ->
            json(put_status(conn, :conflict), %{
              errors: ["A user with that email already exists."]
            })

          _ ->
            json(put_status(conn, :bad_request), %{
              errors: ["There was a problem creating the user"]
            })
        end
    end
  end
end
