defmodule ChoirWeb.ChoirLive do
  use ChoirWeb, :live_view

  alias ChoirWeb.PubSub
  alias ChoirWeb.Presence

  @default_tempo 180
  @local_default %{
    key: 0,
    scale: 0,
    tempo: @default_tempo,
    reverb: 10,
    delay: 10,
    adsr: %{
      a: 1,
      d: 25,
      s: 15,
      r: 35
    }
  }

  def mount(_params, _, socket) do
    if connected?(socket), do: Process.send_after(self(), :clear_flash, 5000)

    topic = "choir"

    PubSub.subscribe(topic)
    Presence.track(self(), topic, socket.id, %{})

    {:ok,
      assign(socket,
        topic: topic,
        local: @local_default,
        global: %{
          users: 1
        }
      )
    }
  end

  # callback for Presence when a user connects/disconnects
  def handle_info(
        %{event: "presence_diff", payload: _payload},
        %{assigns: %{topic: topic, global: g}} = socket
      ) do
    {:noreply, assign(socket, :global, %{g | users: Presence.user_count(topic)})}
  end

  def handle_info(:clear_flash, socket) do
    {:noreply, clear_flash(socket)}
  end
end
