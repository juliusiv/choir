defmodule ChoirWeb.Presence do
  use Phoenix.Presence,
    otp_app: :choir,
    pubsub_server: Choir.PubSub

  def user_count(topic) do
    __MODULE__.list(topic)
    |> Map.keys()
    |> length
  end
end
