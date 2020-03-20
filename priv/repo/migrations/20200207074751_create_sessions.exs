defmodule Choir.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:session) do
      add(:user_id, references(:user, on_delete: :delete_all))
      add(:expires_at, :utc_datetime)

      timestamps()
    end
  end
end
