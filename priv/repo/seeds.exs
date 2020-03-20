# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# It is also run when you use `mix ecto.setup` or `mix ecto.reset`
#

users = [
  %{
    email: "test@example.com",
    password: "password",
    first_name: "Nick",
    last_name: "Zammuto"
  }
]

for user <- users do
  {:ok, _} = Choir.Accounts.create_user(user)
end
