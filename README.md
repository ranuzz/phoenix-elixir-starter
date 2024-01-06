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

```
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

### Start server

run phoenix app and verify that everything is working `mix ecto.create`

[localhost](http://localhost:4000/)

### Add auth

```
mix phx.gen.auth Accounts User users
mix deps.get
mix ecto.migrate
```

### Remove placeholder homepage

Edit `lib/starter_web/controllers/page_html/home.html.heex` and replace the content with

```
<.flash_group flash={@flash} />
<div>Home Page</div>
```

The app should now have auth and a blank home page

<img width="1510" alt="image" src="https://github.com/ranuzz/phoenix-elixir-starter/assets/1070398/149b7b03-25b0-4b80-988b-ba4199b789fb">
