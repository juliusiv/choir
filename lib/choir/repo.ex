defmodule Choir.Repo do
  use Ecto.Repo,
    otp_app: :choir,
    adapter: Ecto.Adapters.Postgres
end
