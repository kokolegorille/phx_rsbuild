defmodule PhxRsbuild.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhxRsbuildWeb.Telemetry,
      PhxRsbuild.Repo,
      # {DNSCluster, query: Application.get_env(:phx_rsbuild, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhxRsbuild.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhxRsbuild.Finch},
      # Start a worker by calling: PhxRsbuild.Worker.start_link(arg)
      # {PhxRsbuild.Worker, arg},
      # Start to serve requests, typically the last entry
      PhxRsbuildWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxRsbuild.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxRsbuildWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
