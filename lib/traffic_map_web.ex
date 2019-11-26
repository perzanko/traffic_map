defmodule TrafficMap.Web do
  def controller do
    quote do
      use Phoenix.Controller, namespace: TrafficMap.Web

      import Plug.Conn
      import TrafficMap.Web.Gettext
      alias TrafficMap.Web.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      use Phoenix.View,
          root: "lib/traffic_map_web/templates",
          namespace: TrafficMap.Web

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      alias TrafficMap.Web.Router.Helpers, as: Routes
      import TrafficMap.Web.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import TrafficMap.Web.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
