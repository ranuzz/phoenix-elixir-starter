# phoenix-elixir-starter

Template to create a starter [phoenix](https://www.phoenixframework.org/) web app

## Build Steps

used to create this template

### Install Elixir

https://elixir-lang.org/install.html

### Install phoenix

```
mix archive.install hex phx_new
```

### Create a new project

```
mix phx.new starter
cd starter

```

### DB setup

- Install [postgres](https://www.postgresql.org/download/)
- Create `starter_dev` db
- Edit `config/dev.exs` if running postgres on a different port

```elixir
# Configure your database
config :starter, Starter.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "starter_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10,
  port: 6432
```

- run `mix ecto.create`

## Start server

run phoenix app and verify that everything is working `mix ecto.create`

[localhost](http://localhost:4000/)

## [step 1 ] Add auth

Generate `Account` context and `users` table along with auth code.

```
mix phx.gen.auth Accounts User users
mix deps.get
mix ecto.migrate
```

auth generation adds two tables `users` and `user_tokens`. The `user` table only contains three columns

- email
- hashed_password
- confirmed_at
  but can be extended to add more columns or etended to support [multitenancy model](https://blitzjs.com/docs/multitenancy)

This includes routes, pages and logic to

- register user
- login user
- changing email and password

## [step 2] UUID as id

change the migration file `priv/repo/migrations/<>_name.exs` to remove default integer `id` primary key and add `id` column that is of type `uuid`

```elixir
    create table(:users, primary_key: false) do
      add(:id, :uuid, primary_key: true)
```

update all references and add type option

```elixir
    create table(:users_tokens, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:user_id, references(:users, type: :uuid, on_delete: :delete_all), null: false)
```

in model schema files add following line to indicate how to autogenerate `uuid`

`lib/starter/accounts/user.ex`
`lib/starter/accounts/user_token.ex`

```elixir
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema ".....
```

add type info in any references in schema
`lib/starter/accounts/user_token.ex`

```elixir
  schema "users_tokens" do
    field(:token, :binary)
    field(:context, :string)
    field(:sent_to, :string)
    belongs_to(:user, Starter.Accounts.User, type: :binary_id)
```

reset DB and run migration again

```
mix ecto.migrate
```

## [Step 3] Add seed data

`priv/repo/seeds.exs`

```elixir
# Cleanup tables
Starter.Repo.delete_all(Starter.Accounts.User)
Starter.Repo.delete_all(Starter.Accounts.UserToken)

Starter.Accounts.register_user(%{
  email: "email@example.com",
  password: "paswordpaswordpasword"
})
```

execute seed file

```
mix run priv/repo/seeds.exs
```

Verify data by running the service in repl

```
iex -S mix phx.server
```

```elixir
iex(1)> Starter.Repo.all(Starter.Accounts.User)
[debug] QUERY OK source="users" db=7.3ms decode=1.2ms queue=1.2ms idle=1816.0ms
SELECT u0."id", u0."email", u0."hashed_password", u0."confirmed_at", u0."inserted_at", u0."updated_at" FROM "users" AS u0 []
↳ :elixir.eval_external_handler/3, at: src/elixir.erl:396
[
  #Starter.Accounts.User<
    __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
    id: "1e1cf2d7-912b-48c8-8723-a15123eb7797",
    email: "email@example.com",
    confirmed_at: nil,
    inserted_at: ~U[2024-01-18 11:24:35Z],
    updated_at: ~U[2024-01-18 11:24:35Z],
    ...
  >
]
```

## [step 4] UI changes

### Install daisyUI

### Add navbar component

### Remove placeholder homepage

Edit `lib/starter_web/controllers/page_html/home.html.heex` and replace the content with

```html
<.flash_group flash={@flash} />
<div>Home Page</div>
```

The app should now have auth and a blank home page

<img width="1510" alt="image" src="https://github.com/ranuzz/phoenix-elixir-starter/assets/1070398/149b7b03-25b0-4b80-988b-ba4199b789fb">

### Add placeholder page component
