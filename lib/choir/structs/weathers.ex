defmodule Choir.Weathers do
  alias Choir.StrictMap, as: StrictMap

  @moduledoc """
  Provides some simple functions for interacting with a collection of Weathers.

  Weathers is implemented as a map for now. This is mainly because the JS
  clients use the Yahoo! Weather API which isn't good about only returning the
  weather conditions that it says it will return; it periodically gives
  unexpected values.
  """

  @doc """
  The Yahoo! weather API says these are the values it will return so only these
  will be accepted. Anything else we get will be "unknown".
  """
  @accepted_weathers MapSet.new(["tornado", "tropical storm", "hurricane",
    "severe thunderstorms", "thunderstorms", "mixed rain and snow",
    "mixed rain and sleet", "mixed snow and sleet", "freezing drizzle",
    "drizzle", "freezing rain", "showers", "showers", "snow flurries",
    "light snow showers", "blowing snow", "snow", "hail", "sleet", "dust",
    "foggy", "haze", "smoky", "blustery", "windy", "cold", "cloudy",
    "mostly cloudy (night)", "mostly cloudy (day)", "partly cloudy (night)",
    "partly cloudy (day)", "clear (night)", "sunny", "fair (night)",
    "fair (day)", "mixed rain and hail", "hot", "isolated thunderstorms",
    "scattered thunderstorms", "scattered thunderstorms", "scattered showers",
    "heavy snow", "scattered snow showers", "heavy snow", "partly cloudy",
    "thundershowers", "snow showers", "isolated thundershowers", "unknown"
  ])

  def new(initial \\ %{}) do
    StrictMap.new(@accepted_weathers, initial)
  end


  def add(old_map, to_add) do
    StrictMap.add(old_map, to_add, @accepted_weathers)
  end


  def remove(old_map, to_remove) do
    StrictMap.remove(old_map, to_remove, @accepted_weathers)
  end
end
