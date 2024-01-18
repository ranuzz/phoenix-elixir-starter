defmodule StarterWeb.LibraryComponents do
  use Phoenix.Component

  slot(:left_actions, default: nil)
  slot(:middle_actions, default: nil)
  slot(:right_actions, default: nil)

  def navbar(assigns) do
    ~H"""
    <div class="navbar bg-primary min-h-[48px] max-h-[48px]">
      <div class="navbar-start">
        <img alt="starter logo" src="/images/logo.svg" class="w-[48px] h-[48px]" />
        <%= render_slot(@right_actions) %>
      </div>
      <div class="navbar-center">
        <%= render_slot(@middle_actions) %>
      </div>
      <div class="navbar-end">
        <%= render_slot(@left_actions) %>
      </div>
    </div>
    """
  end

  slot(:inner_block, required: true)

  def content_placeholder(assigns) do
    ~H"""
    <div class="hero">
      <div class="hero-content text-center">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end
end
