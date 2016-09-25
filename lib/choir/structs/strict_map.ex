defmodule Choir.StrictMap do
  @moduledoc """
  Provides some simple functions for interacting with a map and ensuring only
  certain keys are present.
  """


  @doc """
  Create a new map with only the specified keys and all values 0.

  This function will create a map containing only acceptable keys. All values
  will be greater than or equal to 0. It can be supplied a map of initial
  values.

  Returns a map.
  """
  def new(accepted_keys, initial \\ %{}) do
    default = Map.new(accepted_keys, fn k -> {k, 0} end)
    {initial, _} = Map.split(initial, accepted_keys)
    Map.merge(default, initial, fn _k, vd, vi -> Enum.max([vd, vi]) end)
  end


  defp accepted?(accepted_keys, key) do
    MapSet.member?(accepted_keys, key)
  end


  @doc """
  Increment the field in the map `old_map` corresponding to the key `to_add`.

  Returns a map.
  """
  def add(old_map, to_add, accepted_keys, default \\ "unknown") do
    to_add = if accepted?(accepted_keys, to_add), do: to_add, else: default
    Map.update(old_map, to_add, 1, &(&1+1))
  end


  @doc """
  Decrement the field in the map `old_map` corresponding to the key `to_remove`.

  Returns a map.
  """
  def remove(old_map, to_remove, accepted_keys, default \\ "unknown") do
    to_remove =
      if accepted?(accepted_keys, to_remove), do: to_remove, else: default
    Map.update(old_map, to_remove, 0, &(Enum.max([0, &1-1])))
  end
end
