defmodule Choir.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.UUID

  schema "user" do
    field(:email, :string)
    field(:name, :string)
    field(:password, :string)
    field(:uid, :string)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :password, :uid])
    |> put_change(:uid, UUID.generate())
    |> validate_required([:email, :name, :password, :uid])
  end
end
