defmodule Choir.Browsers do
  alias Choir.StrictMap, as: StrictMap

  @moduledoc """
  Provides some simple functions for interacting with a collection of browsers.
  """


  @accepted_browsers MapSet.new(
    ["opera", "firefox", "safari", "ie", "edge", "chrome", "blink", "unknown"])


  def new(initial \\ %{}) do
    StrictMap.new(@accepted_browsers, initial)
  end


  def add(old_map, to_add) do
    StrictMap.add(old_map, to_add, @accepted_browsers)
  end


  def remove(old_map, to_remove) do
    StrictMap.remove(old_map, to_remove, @accepted_browsers)
  end
end
