defmodule TrafficMap.Web.Endpoint do
  use Phoenix.Endpoint,
      otp_app: :traffic_map

  socket "/socket", TrafficMap.Web.ObservationSocket,
         websocket: true,
         longpoll: false

  plug Plug.Static,
       at: "/",
       from: :traffic_map,
       gzip: false,
       only: ~w(css fonts images js favicon.ico robots.txt)

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
       parsers: [:urlencoded, :multipart, :json],
       pass: ["*/*"],
       json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  plug TrafficMap.Web.Router
end
