defmodule TrafficMap.Web.PageController do
  use TrafficMap.Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
