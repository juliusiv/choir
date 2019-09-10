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

  # The login page is served completely separate from the rest of the app, so we have more control over it and it's
  # more secure (no JS dependencies, third party libs, etc.)
  def login(conn, _params) do
    render(conn, "login.html", uuid: "_login", page: "login")
  end

  def log_in(conn, params) do
    # actually check password hash
    user = Choir.Repo.get_by(User, email: params["email"], password: params["password"])

    case user do
      nil ->
        json(conn |> put_status(:bad_request), %{
          errors: ["Incorrect email/password combination"]
        })

      _ ->
        redirect(conn |> put_session(:user, user.uid), to: "/")
    end
  end

  def signup(conn, _params) do
    render(conn, "signup.html",
      uuid: "_signup",
      page: "signup",
      changeset: User.changeset(%User{}, %{})
    )
  end

  def sign_up(conn, params) do
    changeset = User.changeset(%User{}, params)

    case Choir.Repo.insert(changeset) do
      {:ok, user} ->
        redirect(conn |> put_session(:user, user.uid), to: "/")

      {:error, _} ->
        json(conn |> put_status(:bad_request), %{
          errors: ["There was a problem creating the user"]
        })
    end
  end
end
