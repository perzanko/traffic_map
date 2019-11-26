defmodule TrafficMap.Server do
  use GenServer

  @initial_state %{
    observations_table: nil,
    routes_table: nil
  }

  # Client

  def start_link([]) do
    GenServer.start_link(__MODULE__, @initial_state, name: TrafficMapServer)
  end

  def save_observation(%TrafficMap.Observation{} = observation) do
    GenServer.cast(TrafficMapServer, {:save_observation, observation})
  end

  def save_routes(routes) do
    GenServer.cast(TrafficMapServer, {:save_routes, routes})
  end

  def find_all_observations() do
    GenServer.call(TrafficMapServer, :find_all_observations)
  end

  def find_all_routes() do
    GenServer.call(TrafficMapServer, :find_all_routes)
  end

  # Server (callbacks)

  @impl true
  def init(state) do
    {
      :ok,
      %{
        state |
        observations_table: :ets.new(:traffic_map_observations, []),
        routes_table: :ets.new(:traffic_map_routes, []),
      }
    }
  end

  @impl true
  def handle_cast({:save_observation, observation}, state) do
    :ets.insert(state.observations_table, {observation.id, observation})
    TrafficMap.Web.Endpoint.broadcast("observations", "new_observation", %{data: observation})
    {:noreply, state}
  end

  @impl true
  def handle_cast({:save_routes, routes}, state) do
    if :"$end_of_table" == :ets.last(state.routes_table) do
      routes = routes
               |> Enum.map(fn route -> convert_route_to_ets route end)
      :ets.insert(state.routes_table, routes)
      TrafficMap.Web.Endpoint.broadcast(
        "observations",
        "loaded_routes",
        %{
          data: routes
                |> Enum.map(fn {_, route} -> route end)
        }
      )
    end

    {:noreply, state}
  end

  @impl true
  def handle_call(:find_all_observations, _from, state) do
    observations = :ets.tab2list(state.observations_table)
                   |> Enum.map(fn {id, observation} -> observation end)
    {:reply, observations, state}
  end

  @impl true
  def handle_call(:find_all_routes, _from, state) do
    routes = :ets.tab2list(state.routes_table)
             |> Enum.map(fn {id, route} -> route end)
    {:reply, routes, state}
  end

  defp convert_route_to_ets(
         %Phoenix.Router.Route{path: path, plug: plug, plug_opts: plug_opts, verb: verb, line: line}
       ) do
    {
      line,
      %{
        path: path,
        controller: to_string(plug),
        action: to_string(plug_opts),
        method: to_string(verb)
      }
    }
  end
end
