defmodule TrafficMap.Web.ObservationSocket do
  use Phoenix.Socket

  ## Channels
  channel "observations", TrafficMap.Web.ObservationChannel

  transport(:websocket, Phoenix.Transports.WebSocket)

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
