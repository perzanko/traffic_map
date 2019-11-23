defmodule TrafficMap.ErrorView do
  use TrafficMap.Web, :view

  def render("500.html", _assigns) do
    IO.inspect _assigns
    "Server internal error"
  end

  def render("400.html", _assigns) do
    "Bad request"
  end

  def render("404.html", _assigns) do
    "Not found"
  end

  def render(_, _assigns) do
    "Unknown error"
  end
end
