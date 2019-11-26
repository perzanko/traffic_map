defmodule TrafficMap.Observation.Application do
  @derive Jason.Encoder
  defstruct [
    :controller,
    :action,
    :pid,
  ]
end
