defmodule TrafficMap.Observation do
  defstruct [:id, :request, :response, :issuer, :application, :created_at]

  def construct(conn) do
    %TrafficMap.Observation{
      id: generate_observation_id(),
      request: %TrafficMap.Observation.Request{
        method: conn.method,
        time: :os.system_time(:microsecond) - conn.assigns.traffic_map.start_time,
        body_params: conn.body_params,
        params: conn.params,
        path: conn.request_path,
        query_params: conn.query_params,
        query_string: conn.query_string,
        headers: Enum.map(conn.req_headers, fn {k, v} -> [k, v] end)
      },
      response: %TrafficMap.Observation.Response{
        status: conn.status,
        headers: Enum.map(conn.resp_headers, fn {k, v} -> [k, v] end)
      },
      issuer: %TrafficMap.Observation.Issuer{
        ip: conn.remote_ip
            |> :inet_parse.ntoa()
            |> to_string()
      },
      application: %TrafficMap.Observation.Application{
        controller: to_string(conn.private[:phoenix_controller]),
        action: to_string(conn.private[:phoenix_action]),
        pid: inspect(conn.owner)
      },
      created_at: DateTime.utc_now()
    }
  end

  defp generate_observation_id do
    binary = <<
      System.system_time(:nanosecond) :: 64,
      :erlang.phash2({node(), self()}, 16_777_216) :: 24,
      :erlang.unique_integer() :: 32
    >>

    Base.url_encode64(binary)
  end
end
