defmodule ChoirWeb.Components.Modal do
  use ChoirWeb, :live_component

  def render(%{id_prefix: id_prefix} = assigns) do
    ~H"""
    <div id={"#{id_prefix}-modal"} class={"phx-modal" <> hide?(assigns)}>
      <div
        id={"#{id_prefix}-modal-content"}
        class="phx-modal-content max-w-xs border border-solid border-black modal-content"
        phx-key="escape"
      >
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  defp hide?(%{hide: true}), do: " modal-hide"
  defp hide?(_), do: ""
end
