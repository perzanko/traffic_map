defmodule TrafficMap.Web do
  def controller do
    quote do
      use Phoenix.Controller, namespace: TrafficMap.Web

      import Plug.Conn
      import Phoenix.LiveView.Controller
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

      import Phoenix.LiveView,
             only: [live_render: 2, live_render: 3, live_link: 1, live_link: 2,
               live_component: 2, live_component: 3, live_component: 4]

      alias TrafficMap.Web.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
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
