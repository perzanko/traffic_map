defmodule TrafficMap.Observation.Response do
  @derive Jason.Encoder
  defstruct [
    :status,
    :headers,
  ]
end
