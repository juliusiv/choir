defmodule Choir.AggData do
  defstruct [
    connections: 0,
    avg_temp: nil,
    browsers: %Choir.Browsers{},
    weathers: %Choir.Weathers{},
    avg_location: %Choir.Location{}
  ]

  @doc """
  Add the data in `new_client_data` to the AggData struct `old`.

  Returns a new AggData struct.
  """
  def add_data(old, new_client_data) do
    add_connection(old)
      |> add_temp(new_client_data)
      |> add_browser(new_client_data)
      |> add_weather(new_client_data)
      |> add_location(new_client_data)
  end

  def remove_data(old, client_data) do
    remove_connection(old)
      |> remove_temp(client_data)
      |> remove_browser(client_data)
      |> remove_weather(client_data)
      |> remove_location(client_data)
  end

  @doc """
  Increments the connections field in the AggData struct `old`.

  Returns a new AggData struct.
  """
  def add_connection(old) do
    %{old | connections: old.connections+1}
  end

  @doc """
  Decrements the connections field in the AggData struct `old`.

  Returns a new AggData struct.
  """
  def remove_connection(old) do
    %{old | connections: old.connections-1}
  end

  @doc """
  Updates the AggData struct `old` with a new average temperature
  based on the temperature in `new`.

  When doing a total update of the data be sure to call this after updating
  the connections.

  Returns a new AggData struct.
  """
  def add_temp(old, new) do
    case old.avg_temp do
      nil ->
        %{old | avg_temp: new["temp"]}
      old_avg ->
        %{old | avg_temp: old_avg + (new["temp"] - old_avg)/old.connections}
    end
  end

  @doc """
  Updates the AggData struct `old` by calculating a new average temperature
  based on removing the temperature in `new`.

  When doing a total update of the data be sure to call this after updating
  the connections.

  Returns a new AggData struct.
  """
  def remove_temp(old, new) do
    case old.connections do
      0 -> %{old | avg_temp: nil}
      conns -> %{old | avg_temp: old.avg_temp - (new["temp"] + old.avg_temp)/conns}
    end
  end

  @doc """
  Updates the AggData struct `old` with a new Browsers struct reflecting the new
  client's browser data.

  Returns a new AggData struct.
  """
  def add_browser(old, new) do
    IO.inspect new
    %{old | browsers: Choir.Browsers.add(old.browsers, new["browser"])}
  end

  @doc """
  Updates the AggData struct `old` with a new Browsers struct that has the
  client's browser data removed.

  Returns a new AggData struct.
  """
  def remove_browser(old, client_data) do
    %{old | browsers: Choir.Browsers.remove(old.browsers, client_data["browser"])}
  end

  @doc """
  Updates the AggData struct `old` with a new Weathers struct reflecting the new
  client's weather data.

  Returns a new AggData struct.
  """
  def add_weather(old, new) do
    %{old | weathers: Choir.Weathers.add(old.weathers, new["weather"])}
  end
  
  @doc """
  Updates the AggData struct `old` with a new Weathers struct that has the
  client's weather data removed.

  Returns a new AggData struct.
  """
  def remove_weather(old, client_data) do
    %{old | weathers: Choir.Weathers.remove(old.weathers, client_data["weather"])}
  end

  @doc """
  Updates the AggData struct `old` with a new Location struct reflecting the new
  client's location data.

  Returns a new AggData struct.
  """
  def add_location(old, new) do
    new_loc = %Choir.Location{lat: new["latitude"], lon: new["longitude"]}
    %{old | avg_location: Choir.Location.add(old.avg_location, new_loc, old.connections)}
  end

  @doc """
  Updates the AggData struct `old` with a new Location struct that has the
  client's location data removed.

  Returns a new AggData struct.
  """
  def remove_location(old, client_data) do
    loc = %Choir.Location{lat: client_data["latitude"], lon: client_data["longitude"]}
    %{old | avg_location: Choir.Location.remove(old.avg_location, loc, old.connections)}
  end
end
