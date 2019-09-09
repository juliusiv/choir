defmodule ChoirWeb.PageController do
  use ChoirWeb, :controller
  alias Choir.Users.User

  # The main page is where users hear the music for now. Once we're here, everything else will be handled
  # in the SPA.
  # TODO: This should probably be a signup/in page that will redirect to /listen (or something)
  # if they have an active session.
  def index(conn, _params) do
    uuid = Ecto.UUID.generate()
    IO.inspect(uuid)
    render(conn, "index.html", uuid: uuid, page: "index")
  end

  # The login page is served completely separate from the rest of the app, so we have more control over it and it's
  # more secure (no JS dependencies, third party libs, etc.)
  def login(conn, _params) do
    render(conn, "login.html", uuid: "_login", page: "login")
  end

  def log_in(conn, params) do
    IO.inspect(params)
    # also check password hash
    user = Choir.Repo.get_by(User, email: params["email"])
    redirect(conn |> put_session(:user, user.uid), to: "/")
  end

  def signup(conn, _params) do
    render(conn, "signup.html",
      uuid: "_signup",
      page: "signup",
      changeset: User.changeset(%User{}, %{})
    )
  end

  def sign_up(conn, params) do
    user = User.changeset(%User{}, params)

    case Choir.Repo.insert(user) do
      # don't forget to set the session
      {:ok, _} ->
        redirect(conn |> put_session(:user, user.uid), to: "/")

      {:error, _} ->
        json(conn |> put_status(:bad_request), %{
          errors: ["There was a problem creating the user"]
        })
    end
  end
end
