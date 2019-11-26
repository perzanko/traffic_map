defmodule TrafficMap.Web.Router do
  use TrafficMap.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TrafficMap.Plug
  end

  scope "/", TrafficMap.Web do
    pipe_through(:browser)

    get "/*path", PageController, :index
  end
end
