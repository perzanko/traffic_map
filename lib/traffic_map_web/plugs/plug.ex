defmodule TrafficMap.Plug do
  import Plug.Conn
  require Logger

  def init(router) do
    router
  end

  def call(conn, router) do
    case router do
      [] ->
        conn
      router ->
        save_routes(router)

        conn = assign conn, :traffic_map, %{
          start_time: :os.system_time(:microsecond)
        }

        Plug.Conn.register_before_send(conn, &before_send/1)
    end
  end

  defp save_routes(router) do
    Task.async(fn ->
      TrafficMap.Server.save_routes(router.__routes__)
    end)
  end

  defp before_send(conn) do
    Task.async(
      fn ->
        construct_observation(conn)
        |> TrafficMap.Server.save_observation()
      end
    )

    conn
  end

  defp construct_observation(conn) do
    TrafficMap.Observation.construct(conn)
  end
end
