defmodule TrafficMap.Plug do
  import Plug.Conn
  require Logger

  def init(default), do: default

  def call(conn, _) do
    conn = assign conn, :traffic_map, %{
      start_time: :os.system_time(:microsecond)
    }

    Plug.Conn.register_before_send(conn, &before_send/1)
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
