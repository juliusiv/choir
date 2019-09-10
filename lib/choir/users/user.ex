defmodule Choir.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.UUID

  schema "user" do
    field(:email, :string, null: false)
    field(:name, :string, null: false)
    field(:password, :string, null: false)
    field(:uid, :string, null: false)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    u =
      user
      |> cast(attrs, [:email, :name, :password, :uid])
      |> put_change(:uid, UUID.generate())
      |> validate_required([:email, :name, :password, :uid])

    # IO.inspect(u)
    u
  end
end
