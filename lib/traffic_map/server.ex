defmodule TrafficMap.Server do
  use GenServer

  @initial_state %{
    observations_table: nil
  }

  # Client

  def start_link([]) do
    GenServer.start_link(__MODULE__, @initial_state, name: TrafficMapServer)
  end

  # Client

  def save_observation(%TrafficMap.Observation{} = observation) do
    GenServer.cast(TrafficMapServer, {:save_observation, observation})
  end

  # Server (callbacks)

  @impl true
  def init(state) do
    {
      :ok,
      %{
        state |
        observations_table: :ets.new(:traffic_map_observations, [])
      }
    }
  end

  @impl true
  def handle_cast({:save_observation, observation}, state) do
    :ets.insert(state.observations_table, {observation.id, observation})

    IO.inspect :ets.tab2list(state.observations_table), label: :list_of_all_keys_from_table
    {:noreply, state}
  end
end
