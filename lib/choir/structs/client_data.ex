defmodule Choir.ClientData do
  defstruct [
    lat: nil,
    lon: nil,
    temp: nil,
    browser: nil,
    weather: nil
  ]
  use ExConstructor
end
