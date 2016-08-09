defmodule Choir.Browsers do
  defstruct opera: 0, firefox: 0, safari: 0, ie: 0, edge: 0, chrome: 0, blink: 0, unknown: 0


  @doc """
  Increments the field in the Browsers struct `old` that corresponds to the atom
  `new`.

  Returns an updated Browsers struct.
  """
  def add(old, new) do
    case new do
      "opera" -> %{old | opera: old.opera+1}
      "firefox" -> %{old | firefox: old.firefox+1}
      "safari" -> %{old | safari: old.safari+1}
      "ie" -> %{old | ie: old.ie+1}
      "edge" -> %{old | edge: old.edge+1}
      "chrome" -> %{old | chrome: old.chrome+1}
      "blink" -> %{old | blink: old.blink+1}
      "unknown" -> %{old | unknown: old.unknown+1}
    end
  end

  @doc """
  Decrements the field in the Browsers struct `old` that corresponds to the atom
  `new`.

  Returns an updated Browsers struct.
  """
  def remove(old, new) do
    case new do
      "opera" -> %{old | opera: old.opera-1}
      "firefox" -> %{old | firefox: old.firefox-1}
      "safari" -> %{old | safari: old.safari-1}
      "ie" -> %{old | ie: old.ie-1}
      "edge" -> %{old | edge: old.edge-1}
      "chrome" -> %{old | chrome: old.chrome-1}
      "blink" -> %{old | blink: old.blink-1}
      "unknown" -> %{old | unknown: old.unknown-1}
    end
  end
end
