defmodule ChoirWeb.PageController do
  use ChoirWeb, :controller
  alias Choir.Accounts.User

  import ChoirWeb.Authorize

  alias Phauxth.Login
  alias Choir.{Sessions, Sessions.Session}

  # The main page is where users hear the music for now. Once we're here, everything else will be handled
  # in the SPA.
  # TODO: This should probably be a signup/in page that will redirect to /listen (or something)
  # if they have an active session.
  def index(conn, _params) do
    render(conn, "index.html", uuid: Ecto.UUID.generate(), page: "index")
  end

  defp set_user_session(conn, user) do
    token = Phoenix.Token.sign(conn, "auth", user.uid)
    conn |> put_session(:token, token)
  end

  def log_in(conn, params) do
    # def log_in(conn, %{"session" => params}) do
    # case Login.verify(params) do
    #   {:ok, user} ->
    #     conn
    #     |> add_session(user, params)
    #     |> put_flash(:info, "User successfully logged in.")
    #     |> redirect(to: get_session(conn, :request_path) || Routes.user_path(conn, :index))

    #   {:error, message} ->
    #     conn
    #     |> put_flash(:error, message)
    #     |> redirect(to: Routes.session_path(conn, :new))
    # end
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

  def log_out(conn, _params) do
    conn |> delete_session(:token) |> send_resp(:ok, "")
  end
end
