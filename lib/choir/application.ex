defmodule Choir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ChoirWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Choir.PubSub},
      # Start the Endpoint (http/https)
      ChoirWeb.Endpoint,
      # Start a worker by calling: Choir.Worker.start_link(arg)
      # {Choir.Worker, arg}
      ChoirWeb.Presence
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Choir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChoirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
