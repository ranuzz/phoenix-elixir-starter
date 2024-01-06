defmodule Starter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      StarterWeb.Telemetry,
      Starter.Repo,
      {DNSCluster, query: Application.get_env(:starter, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Starter.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Starter.Finch},
      # Start a worker by calling: Starter.Worker.start_link(arg)
      # {Starter.Worker, arg},
      # Start to serve requests, typically the last entry
      StarterWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Starter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StarterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
