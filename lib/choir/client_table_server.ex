defmodule Choir.ClientTableServer do
  use GenServer
  # Store map of socket to data for the client.

  # ============================================================================
  ## Client API
  # ============================================================================

  @doc """
  Starts the registry.
  """
  def start_link do
    GenServer.start_link(__MODULE__, :client_table, [name: :client_table])
  end

  @doc """
  Looks up the data for `socket` stored in `server`.

  Returns `{:ok, pid}` if the socket exists, `:error` otherwise.
  """
  def lookup(socket) do
    client_id = socket.assigns.client_id
    case :ets.lookup(:client_table, client_id) do
      [{^client_id, data}] -> {:ok, data}
      # [{^client_id, data}] -> {:ok, %{:blah => "whocares"}}
      [] -> :error
    end
  end

  @doc """
  Inserts the {`socket`, `data`} pair into the ETS table.
  """
  def insert(socket, data) do
    :ets.insert(:client_table, {socket.assigns.client_id, data})
  end

  @doc """
  Deletes the entry for the key `socket`.

  Returns the data associated with the `socket` if it exists, `:error`
  otherwise.
  """
  def delete(socket) do
    case lookup(socket) do
      {:ok, data} ->
        :ets.delete(:client_table, socket.assigns.client_id)
        {:ok, data}
      :error -> :error
    end
  end

  def stop(server) do
    GenServer.stop(server)
  end

  # ============================================================================
  ## Server Callbacks
  # ============================================================================

  def init(table) do
    table = :ets.new(table, [:set, :public, :named_table])
    {:ok, {table}}
  end
end
