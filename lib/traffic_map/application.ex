defmodule TrafficMap.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {TrafficMap.Server, []},
      TrafficMap.Web.Endpoint,
    ]

    opts = [strategy: :one_for_one, name: TrafficMap.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
