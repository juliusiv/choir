defmodule Choir.Weathers do
  defstruct tornado: 0, tropical_storm: 0, hurricane: 0, severe_thunderstorms: 0, thunderstorms: 0, mixed_rain_and_snow: 0, mixed_rain_and_sleet: 0, mixed_snow_and_sleet: 0, freezing_drizzle: 0, drizzle: 0, freezing_rain: 0, showers: 0, showers: 0, snow_flurries: 0, light_snow_showers: 0, blowing_snow: 0, snow: 0, hail: 0, sleet: 0, dust: 0, foggy: 0, haze: 0, smoky: 0, blustery: 0, windy: 0, cold: 0, cloudy: 0, mostly_cloudy_night: 0, mostly_cloudy_day: 0, partly_cloudy_night: 0, partly_cloudy_day: 0, clear_night: 0, sunny: 0, fair_night: 0, fair_day: 0, mixed_rain_and_hail: 0, hot: 0, isolated_thunderstorms: 0, scattered_thunderstorms: 0, scattered_thunderstorms: 0, scattered_showers: 0, heavy_snow: 0, scattered_snow_showers: 0, heavy_snow: 0, partly_cloudy: 0, thundershowers: 0, snow_showers: 0, isolated_thundershowers: 0, mostly_cloudy: 0

  @doc """
  Increments the field in the Weathers struct `old` that corresponds to the atom
  `new`.

  Returns an updated Weathers struct.
  """
  def add(old, new) do
    case new do
      "tornado" -> %{old | tornado: old.tornado+1}
      "tropical storm" -> %{old | tropical_storm: old.tropical_storm+1}
      "hurricane" -> %{old | hurricane: old.hurricane+1}
      "severe thunderstorms" -> %{old | severe_thunderstorms: old.severe_thunderstorms+1}
      "thunderstorms" -> %{old | thunderstorms: old.thunderstorms+1}
      "mixed rain and snow" -> %{old | mixed_rain_and_snow: old.mixed_rain_and_snow+1}
      "mixed rain and sleet" -> %{old | mixed_rain_and_sleet: old.mixed_rain_and_sleet+1}
      "mixed snow and sleet" -> %{old | mixed_snow_and_sleet: old.mixed_snow_and_sleet+1}
      "freezing drizzle" -> %{old | freezing_drizzle: old.freezing_drizzle+1}
      "drizzle" -> %{old | drizzle: old.drizzle+1}
      "freezing rain" -> %{old | freezing_rain: old.freezing_rain+1}
      "showers" -> %{old | showers: old.showers+1}
      "snow flurries" -> %{old | snow_flurries: old.snow_flurries+1}
      "light snow showers" -> %{old | light_snow_showers: old.light_snow_showers+1}
      "blowing snow" -> %{old | blowing_snow: old.blowing_snow+1}
      "snow" -> %{old | snow: old.snow+1}
      "hail" -> %{old | hail: old.hail+1}
      "sleet" -> %{old | sleet: old.sleet+1}
      "dust" -> %{old | dust: old.dust+1}
      "foggy" -> %{old | foggy: old.foggy+1}
      "haze" -> %{old | haze: old.haze+1}
      "smoky" -> %{old | smoky: old.smoky+1}
      "blustery" -> %{old | blustery: old.blustery+1}
      "windy" -> %{old | windy: old.windy+1}
      "cold" -> %{old | cold: old.cold+1}
      "cloudy" -> %{old | cloudy: old.cloudy+1}
      "mostly cloudy (night)" -> %{old | mostly_cloudy_night: old.mostly_cloudy_night+1}
      "mostly cloudy (day)" -> %{old | mostly_cloudy_day: old.mostly_cloudy_day+1}
      "partly cloudy (night)" -> %{old | partly_cloudy_night: old.partly_cloudy_night+1}
      "partly cloudy (day)" -> %{old | partly_cloudy_day: old.partly_cloudy_day+1}
      "clear (night)" -> %{old | clear_night: old.clear_night+1}
      "sunny" -> %{old | sunny: old.sunny+1}
      "fair (night)" -> %{old | fair_night: old.fair_night+1}
      "fair (day)" -> %{old | fair_day: old.fair_day+1}
      "mixed_rain_and_hail" -> %{old | mixed_rain_and_hail: old.mixed_rain_and_hail+1}
      "hot" -> %{old | hot: old.hot+1}
      "isolated thunderstorms" -> %{old | isolated_thunderstorms: old.isolated_thunderstorms+1}
      "scattered thunderstorms" -> %{old | scattered_thunderstorms: old.scattered_thunderstorms+1}
      "scattered showers" -> %{old | scattered_showers: old.scattered_showers+1}
      "heavy snow" -> %{old | heavy_snow: old.heavy_snow+1}
      "scattered snow showers" -> %{old | scattered_snow_showers: old.scattered_snow_showers+1}
      "partly cloudy" -> %{old | partly_cloudy: old.partly_cloudy+1}
      "thundershowers" -> %{old | thundershowers: old.thundershowers+1}
      "snow showers" -> %{old | snow_showers: old.snow_showers+1}
      "isolated thundershowers" -> %{old | isolated_thundershowers: old.isolated_thundershowers+1}
      "mostly cloudy" -> %{old | mostly_cloudy: old.mostly_cloudy+1}
    end
  end

  @doc """
  Decrements the field in the Weathers struct `old` that corresponds to the atom
  `new`.

  Returns an updated Weathers struct.
  """
  def remove(old, new) do
    case new do
      "tornado" -> %{old | tornado: old.tornado-1}
      "tropical storm" -> %{old | tropical_storm: old.tropical_storm-1}
      "hurricane" -> %{old | hurricane: old.hurricane-1}
      "severe thunderstorms" -> %{old | severe_thunderstorms: old.severe_thunderstorms-1}
      "thunderstorms" -> %{old | thunderstorms: old.thunderstorms-1}
      "mixed rain and snow" -> %{old | mixed_rain_and_snow: old.mixed_rain_and_snow-1}
      "mixed rain and sleet" -> %{old | mixed_rain_and_sleet: old.mixed_rain_and_sleet-1}
      "mixed snow and sleet" -> %{old | mixed_snow_and_sleet: old.mixed_snow_and_sleet-1}
      "freezing drizzle" -> %{old | freezing_drizzle: old.freezing_drizzle-1}
      "drizzle" -> %{old | drizzle: old.drizzle-1}
      "freezing rain" -> %{old | freezing_rain: old.freezing_rain-1}
      "showers" -> %{old | showers: old.showers-1}
      "snow flurries" -> %{old | snow_flurries: old.snow_flurries-1}
      "light snow showers" -> %{old | light_snow_showers: old.light_snow_showers-1}
      "blowing snow" -> %{old | blowing_snow: old.blowing_snow-1}
      "snow" -> %{old | snow: old.snow-1}
      "hail" -> %{old | hail: old.hail-1}
      "sleet" -> %{old | sleet: old.sleet-1}
      "dust" -> %{old | dust: old.dust-1}
      "foggy" -> %{old | foggy: old.foggy-1}
      "haze" -> %{old | haze: old.haze-1}
      "smoky" -> %{old | smoky: old.smoky-1}
      "blustery" -> %{old | blustery: old.blustery-1}
      "windy" -> %{old | windy: old.windy-1}
      "cold" -> %{old | cold: old.cold-1}
      "cloudy" -> %{old | cloudy: old.cloudy-1}
      "mostly cloudy (night)" -> %{old | mostly_cloudy_night: old.mostly_cloudy_night-1}
      "mostly cloudy (day)" -> %{old | mostly_cloudy_day: old.mostly_cloudy_day-1}
      "partly cloudy (night)" -> %{old | partly_cloudy_night: old.partly_cloudy_night-1}
      "partly cloudy (day)" -> %{old | partly_cloudy_day: old.partly_cloudy_day-1}
      "clear (night)" -> %{old | clear_night: old.clear_night-1}
      "sunny" -> %{old | sunny: old.sunny-1}
      "fair (night)" -> %{old | fair_night: old.fair_night-1}
      "fair (day)" -> %{old | fair_day: old.fair_day-1}
      "mixed_rain_and_hail" -> %{old | mixed_rain_and_hail: old.mixed_rain_and_hail-1}
      "hot" -> %{old | hot: old.hot-1}
      "isolated thunderstorms" -> %{old | isolated_thunderstorms: old.isolated_thunderstorms-1}
      "scattered thunderstorms" -> %{old | scattered_thunderstorms: old.scattered_thunderstorms-1}
      "scattered showers" -> %{old | scattered_showers: old.scattered_showers-1}
      "heavy snow" -> %{old | heavy_snow: old.heavy_snow-1}
      "scattered snow showers" -> %{old | scattered_snow_showers: old.scattered_snow_showers-1}
      "partly cloudy" -> %{old | partly_cloudy: old.partly_cloudy-1}
      "thundershowers" -> %{old | thundershowers: old.thundershowers-1}
      "snow showers" -> %{old | snow_showers: old.snow_showers-1}
      "isolated thundershowers" -> %{old | isolated_thundershowers: old.isolated_thundershowers-1}
      "mostly cloudy" -> %{old | mostly_cloudy: old.mostly_cloudy-1}
    end
  end
end