# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Starter.Repo.insert!(%Starter.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Cleanup tables
Starter.Repo.delete_all(Starter.Accounts.User)
Starter.Repo.delete_all(Starter.Accounts.UserToken)

Starter.Accounts.register_user(%{
  email: "email@example.com",
  password: "paswordpaswordpasword"
})
