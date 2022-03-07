defmodule ChoirWeb.PubSub do
  alias Phoenix.PubSub

  def subscribe(topic) do
    PubSub.subscribe(Choir.PubSub, topic)
  end

  def broadcast(topic, data) do
    PubSub.broadcast(Choir.PubSub, topic, data)
  end
end
