defmodule ChoirWeb.ListenChannel do
  use ChoirWeb, :channel

  def join(channel_name, _params, socket) do
    # IO.inspect(Choir.Connections.get())
    connections = Choir.Connections.add()
    {:ok, connections, socket}
  end

  def terminate(_reason, _) do
    IO.puts("leave")
    Choir.Connections.remove()
    # {:ok, connections, socket}
  end

  # When the server gets a listen:data message it adds it into its connection data.
  # When it broadcasts a listen:data message it's telling the clients to pipe the
  # data into the synth.
  def handle_in("listen:data", data, socket) do
    # broadcast!(socket, "listen:data", :rand.uniform(100))
    broadcast!(socket, "listen:data", Choir.Connections.get())
    # broadcast!(socket, "listen:data", Choir.Connections.get())
    {:reply, :ok, socket}
  end
end
