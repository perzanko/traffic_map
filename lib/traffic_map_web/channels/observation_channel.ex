defmodule TrafficMap.Web.ObservationChannel do
  use TrafficMap.Web, :channel

  def connect("connect", payload, socket) do
    send(self(), :after_connect)
    {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # example see: https://git.io/vNsYD
  def handle_info(:after_connect, socket) do
    # :noreply
    {:noreply, socket}
  end
end
