defmodule Choir.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :email, :string
      add :name, :string
      add :password, :string
      add :uid, :string

      timestamps()
    end

  end
end
