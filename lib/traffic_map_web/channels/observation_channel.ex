defmodule TrafficMap.Web.ObservationChannel do
  use TrafficMap.Web, :channel

  def join("observations", _message, socket) do
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    push socket, "join", %{status: "connected"}
    {:noreply, socket}
  end

  def terminate(reason, _socket) do
    :ok
  end

  def handle_in("load_observations", msg, socket) do
    broadcast! socket, "loaded_observations", %{data: TrafficMap.Server.find_all_observations}
    {:noreply, socket}
  end

  def handle_in("load_routes", msg, socket) do
    broadcast! socket, "loaded_routes", %{data: TrafficMap.Server.find_all_routes}
    {:noreply, socket}
  end
end
