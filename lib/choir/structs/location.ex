defmodule Choir.Location do
  defstruct lat: nil, lon: nil

  @doc """
  Calculates a new average location based on new client data.

  Returns an updated Location struct.
  """
  def add(old, new, conns) do
    case {old.lat, old.lon} do
      {nil, nil} -> %{old | lat: new.lat, lon: new.lon}
      {nil, _} -> %{old | lat: nil, lon: nil}
      {_, nil} -> %{old | lat: nil, lon: nil}
      {old_lat, old_lon} -> %{old | lat: old_lat + (new.lat - old_lat)/conns,
                                    lon: old_lon + (new.lon - old_lon)/conns}
    end
  end

  @doc """
  Calculates a new average location based on removed client data.

  Returns an updated Location struct.
  """
  def remove(old, client_data, conns) do
    case conns do
      0 -> %{old | lat: nil, lon: nil}
      _ -> %{old | lat: old.lat - (client_data.lat + old.lat)/conns,
                   lon: old.lon - (client_data.lon + old.lon)/conns}
    end
  end
end
