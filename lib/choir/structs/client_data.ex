defmodule Choir.ClientData do
  defstruct [
    latitude: nil,
    longitude: nil,
    temp: nil,
    browser: nil,
    weather: nil
  ]
  use ExConstructor
end
