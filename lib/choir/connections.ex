defmodule Choir.Connections do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{count: 0} end, name: __MODULE__)
  end

  def add(count \\ 1) do
    Agent.update(__MODULE__, fn state -> Map.update(state, :count, 0, &(&1 + 1)) end)
  end

  def remove(count \\ 1) do
    Agent.update(__MODULE__, fn state -> Map.update(state, :count, 0, &(&1 - 1)) end)
  end

  def aggregate do
    Agent.get()
  end

  def get do
    Agent.get(__MODULE__, & &1)
  end
end
