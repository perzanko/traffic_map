defmodule TrafficMap.Observation.Request do
  @derive Jason.Encoder
  defstruct [
    :method,
    :time,
    :body_params,
    :params,
    :path,
    :query_params,
    :query_string,
    :headers,
  ]
end
