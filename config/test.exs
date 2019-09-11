use Mix.Config

# Configure your database
config :choir, Choir.Repo,
  username: "postgres",
  password: "postgres",
  database: "choir_test",
  port: System.get_env("POSTGRES_PORT"),
  pool: Ecto.Adapters.SQL.Sandbox,
  hostname: System.get_env("POSTGRES_HOST", "localhost")

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :choir, ChoirWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :bcrypt_elixir, log_rounds: 4
