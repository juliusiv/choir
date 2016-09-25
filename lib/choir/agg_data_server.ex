defmodule Choir.AggDataServer do
  use GenServer

  # ============================================================================
  ## Client API
  # ============================================================================

  @doc """
  Starts the registry.
  """
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [name: __MODULE__])
  end

  @doc """
  Looks up the bucket pid for `data_point`.

  Returns `{:ok, value}` if the data exists, `:error` otherwise.
  """
  def lookup(data_point) do
    GenServer.call(__MODULE__, {:lookup, data_point})
  end

  @doc """
  Ensures there is a bucket associated to the given `name` in `server`.
  """
  def create(name) do
    GenServer.cast(__MODULE__, {:create, name})
  end

  def dump do
    GenServer.call(__MODULE__, {:dump})
  end

  # TODO: This should maybe be made a cast at some point. For now it will be
  # synchronous.
  def add_data(new_data) do
    GenServer.call(__MODULE__, {:add_data, new_data})
  end

  def remove_data(new_data) do
    GenServer.call(__MODULE__, {:remove_data, new_data})
  end

  # TODO: Maybe move all this work into the server callbacks so there aren't
  # multiple calls happening for one operation. More atomic, probably faster.
  def update_data(socket, new_data) do
    old_data = Choir.ClientTableServer.lookup(socket)
    remove_data(old_data)
    # `insert` will update existing data if the `socket` already exists.
    Choir.ClientTableServer.insert(socket, new_data)
    add_data(new_data)
  end

  # ============================================================================
  ## Server Callbacks
  # ============================================================================

  def init(:ok) do
    {:ok, %Choir.AggData{}}
  end

  def handle_call({:lookup, data_point}, _from, voices) do
    {:reply, Map.fetch(voices, data_point), voices}
  end
  # This callback actually returns the second element of the tuple when called
  # through GenServer so there's no need to pattern match it.
  def handle_call({:dump}, _from, voices) do
    {:reply, voices, voices}
  end
  def handle_call({:add_data, new_data}, _from, voices) do
    updated_voices = Choir.AggData.add_data(voices, new_data)
    {:reply, updated_voices, updated_voices}
  end
  def handle_call({:remove_data, data}, _from, voices) do
    updated_voices = Choir.AggData.remove_data(voices, data)
    {:reply, updated_voices, updated_voices}
  end

  def handle_cast({:create, _voice}, voices) do
    {:noreply, voices}
  end

  @doc """
  Calculate a new average.
  """
  def calc_new_avg(new_val, curr_avg, n) do
    case curr_avg do
      nil -> new_val
      _ -> curr_avg + (new_val - curr_avg)/n
    end
  end
end
