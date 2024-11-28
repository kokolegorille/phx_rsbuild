defmodule PhxRsbuild.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    pubsub = Application.fetch_env!(:phx_rsbuild, :pubsub)
    children = [
      PhxRsbuildWeb.Telemetry,
      PhxRsbuild.Repo,
      # {DNSCluster, query: Application.get_env(:phx_rsbuild, :dns_cluster_query) || :ignore},
      # {Phoenix.PubSub, name: PhxRsbuild.PubSub},
      {Phoenix.PubSub, name: pubsub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhxRsbuild.Finch},
      # Start a worker by calling: PhxRsbuild.Worker.start_link(arg)
      # {PhxRsbuild.Worker, arg},

      # LibCluster
      {Cluster.Supervisor, [topologies(), [name: Prem.ClusterSupervisor]]},

      # Start to serve requests, typically the last entry
      PhxRsbuildWeb.Endpoint,
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

  defp topologies do
    [
      prem: [
        # The selected clustering strategy. Required.
        strategy: Application.get_env(:phx_rsbuild, :strategy, Cluster.Strategy.Epmd),
        # Configuration for the provided strategy. Optional.
        config: [hosts: Application.fetch_env!(:phx_rsbuild, :hosts)],

        # # The function to use for connecting nodes. The node
        # # name will be appended to the argument list. Optional
        # connect: {:net_kernel, :connect_node, []},
        # # The function to use for disconnecting nodes. The node
        # # name will be appended to the argument list. Optional
        # disconnect: {:erlang, :disconnect_node, []},
        # # The function to use for listing nodes.
        # # This function must return a list of node names. Optional
        # list_nodes: {:erlang, :nodes, [:connected]},
      ]
    ]
  end
end
