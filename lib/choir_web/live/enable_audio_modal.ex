defmodule ChoirWeb.Components.EnableAudioModal do
  use ChoirWeb, :live_component

  alias Phoenix.LiveView.JS

  @prefix "enable-audio"

  def hide_modal(js \\ %JS{}) do
    js
    |> JS.add_class("closing", to: "##{@prefix}-modal-content")
    |> JS.hide(transition: "fade-out", to: "##{@prefix}-modal")
    |> JS.hide(transition: "fade-out-scale", to: "##{@prefix}-modal-content")
  end

  def render(assigns) do
    ~H"""
    <C.Modal.render id_prefix={prefix()} phx-remove={hide_modal()}>
      <section class="text-center">
        <p>Welcome to Choir.</p>
        <p>Audio will have to be enabled before you can continue.</p>
        <button id="enable-audio-btn" class="modal-button border border-solid border-black p-2" phx-click={hide_modal()}>enable audio</button>
      </section>
    </C.Modal.render>
    """
  end

  defp prefix do
    @prefix
  end
end
