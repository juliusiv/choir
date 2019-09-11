defmodule Choir.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.UUID
  # alias Bcrypt

  schema "user" do
    field(:email, :string, null: false)
    field(:name, :string, null: false)
    field(:password, :string, virtual: true)
    field(:password_hash, :string, null: false)
    field(:uid, :string, null: false)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :password, :uid])
    |> put_change(:uid, UUID.generate())
    |> put_password_hash
    |> validate_required([:email, :name, :password_hash, :uid])
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
