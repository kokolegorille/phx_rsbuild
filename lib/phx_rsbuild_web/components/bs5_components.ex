defmodule PhxRsbuildWeb.Bs5Components do
  @moduledoc """
  Provides Bootstrap 5 UI components.
  """
  use Phoenix.Component
  # import PhxRsbuildWeb.Gettext
  use Gettext, backend: PhxRsbuildWeb.Gettext

  import PhxRsbuildWeb.CoreComponents, only: [icon: 1]

  # Enable ~p sigil
  use PhxRsbuildWeb, :verified_routes

  alias PhxRsbuildWeb.SearchForm

  @doc """
  Renders an accordion.
  """

  attr :id, :string, required: true

  slot :inner_block, required: true

  def accordion(assigns) do
    ~H"""
    <div class="accordion" id={@id}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr :id, :string, required: true
  attr :parent_id, :string, required: true
  attr :label, :string, required: true
  attr :collapsed, :boolean, default: true

  slot :inner_block, required: true

  def accordion_item(assigns) do
    ~H"""
    <div class="accordion-item">
      <h2 class="accordion-header">
        <button
          class={if @collapsed, do: "accordion-button collapsed", else: "accordion-button"}
          type="button"
          data-bs-toggle="collapse"
          data-bs-target={"#collapse_#{@id}"}
          aria-expanded="true"
          aria-controls={"collapse_#{@id}"}>
        <%= @label %>
        </button>
      </h2>
      <div
        id={"collapse_#{@id}"}
        class={if @collapsed, do: "accordion-collapse collapse", else: "accordion-collapse show"}
        data-bs-parent={@parent_id}>
        <div class="accordion-body">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Renders a badge.
  """

  attr :class, :string, default: nil
  attr :default_class, :string, default: "badge"

  slot :inner_block

  def badge(assigns) do
    ~H"""
    <span class={[@default_class, @class]}>
      <%= render_slot(@inner_block) %>
    </span>
    """
  end

  @doc """
  Renders a breadcrumb.
  """

  attr :class, :string, default: "breadcrumb"

  slot :inner_block

  def breadcrumb(assigns) do
    ~H"""
    <nav aria-label="breadcrumb" aria-label="breadcrumb">
      <ol class={@class}>
        <%= render_slot(@inner_block) %>
      </ol>
    </nav>
    """
  end

  @doc """
  Renders a breadcrumb item.
  """

  attr :class, :string, default: nil
  attr :default_class, :string, default: "breadcrumb-item"
  attr :rest, :global

  slot :inner_block

  def breadcrumb_item(assigns) do
    ~H"""
    <li class={[@default_class, @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </li>
    """
  end

  @doc """
  Renders a carousel.

  TODO:
    => Indicators
    => Captions
    => Crossfade
    => Autoplay
  """

  # <.carousel id="carosello">
  #   <.carousel_item img={~p"/images/pittsburgh_sm.jpg"} class="carousel-item active" />
  #   <.carousel_item img={~p"/images/port_au_prince_sm.jpg"} />
  # </.carousel>

  # attr :id, :string, required: true
  # attr :class, :string, default: nil
  # attr :default_class, :string, default: "carousel slide"

  # slot :indicators
  # slot :inner_block

  # def carousel(assigns) do
  #   ~H"""
  #   <div id={@id} class={[@default_class, @class]}>
  #     <div class="carousel-inner">
  #       <%= render_slot(@inner_block) %>
  #     </div>

  #     <button class="carousel-control-prev" type="button" data-bs-target={"##{@id}"} data-bs-slide="prev">
  #       <span class="carousel-control-prev-icon" aria-hidden="true"></span>
  #       <span class="visually-hidden">Previous</span>
  #     </button>
  #     <button class="carousel-control-next" type="button" data-bs-target={"##{@id}"} data-bs-slide="next">
  #       <span class="carousel-control-next-icon" aria-hidden="true"></span>
  #       <span class="visually-hidden">Next</span>
  #     </button>
  #   </div>
  #   """
  # end

  # attr :img, :string, required: true
  # attr :img_class, :string, default: "d-block w-100"
  # attr :class, :string, default: "carousel-item"
  # attr :rest, :global

  # def carousel_item(assigns) do
  #   ~H"""
  #   <div class={@class}>
  #     <img src={@img} class={@img_class} {@rest} />
  #   </div>
  #   """
  # end

  attr :id, :string, required: true
  attr :items, :list, required: true
  attr :autoplay, :boolean, default: false
  attr :controls, :boolean, default: false
  attr :indicators, :boolean, default: false
  attr :class, :string, default: nil
  attr :default_class, :string, default: "carousel slide"

  def carousel(assigns) do
    ~H"""
    <div id={@id} class={[@default_class, @class]} data-bs-ride={if @autoplay, do: "carousel", else: false}>
      <div :if={@indicators} class="carousel-indicators">
        <button
          :for={{item, index} <- Enum.with_index(@items)}
          type="button"
          data-bs-target={"##{@id}"}
          data-bs-slide-to={index}
          class={if item[:active], do: "active", else: ""}
          aria-current={if item[:active], do: true, else: false}
          aria-label={"Slide #{index}"}>
        </button>
      </div>

      <div class="carousel-inner">
        <div :for={item <- @items} class={["carousel-item", (if item[:active], do: "active", else: "")]}>
          <img src={item.img} class="d-block w-100" />
          <div :if={item[:caption]} class="carousel-caption d-none d-md-block">
            <h5><%= item[:caption][:title] %></h5>
            <p><%= item[:caption][:content] %></p>
          </div>
        </div>
      </div>

      <button :if={@controls} class="carousel-control-prev" type="button" data-bs-target={"##{@id}"} data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button :if={@controls} class="carousel-control-next" type="button" data-bs-target={"##{@id}"} data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>
    """
  end

  @doc """
  Renders a dropdown.

    ## Examples

      <.dropdown label="Settings" class="btn-info">
        <:item><.link navigate={~p"/admin/users"} class="dropdown-item">Users</.link></:item>
        <:item><hr class="dropdown-divider" /></:item>
        <:item><.link navigate={~p"/"} class="dropdown-item">Home</.link></:item>
      </.dropdown>
  """

  attr :label, :string, required: true
  attr :class, :string, default: "btn-primary"
  slot :item, required: true

  def dropdown(assigns) do
    ~H"""
    <div class="dropdown">
      <button class={["btn dropdown-toggle", @class]}
        type="button"
        data-bs-toggle="dropdown"
        aria-expanded="false">
        <%= @label %>
      </button>
      <ul class="dropdown-menu">
        <%= for item <- @item do %>
          <li><%= render_slot(item) %></li>
        <% end %>
      </ul>
    </div>
    """
  end

  def topbar(assigns) do
    ~H"""
    <nav id="top-navbar" class="navbar fixed-top navbar-expand">
      <div class="container-fluid">
        <.nav
          :if={assigns[:right_links]}
          class="navbar-nav ms-auto"
          current_user={@current_user}
          links={@right_links} />
      </div>
    </nav>
    """
  end

  def navbar(assigns) do
    ~H"""
    <nav id="main-navbar" class="navbar navbar-expand-md">
      <div class="container-fluid">
          <button
              class="navbar-toggler"
              type="button"
              data-bs-toggle="collapse"
              data-bs-target="#navbarSupportedContent"
              aria-controls="navbarSupportedContent"
              aria-expanded="false"
              aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarSupportedContent">

            <.nav
              :if={assigns[:left_links]}
              class="navbar-nav me-auto"
              current_user={@current_user}
              links={@left_links} />

            <.nav
              :if={assigns[:right_links]}
              class="navbar-nav ms-auto"
              current_user={@current_user}
              links={@right_links} />

          </div>
      </div>
    </nav>
    """
  end

  def nav(assigns) do
    ~H"""
    <ul class={@class}>
      <%= for link <- @links do %>

        <%= case link do %>
          <% {:link, {label, url}} -> %>
            <li class="nav-item">
              <.link navigate={url} class="nav-link"><%= label %></.link>
            </li>
          <% {:href, {label, url}} -> %>
            <li class="nav-item">
              <.link href={url} class="nav-link"><%= label %></.link>
            </li>
          <% {:delete_link, {label, url}} -> %>
            <li class="nav-item">
              <.link href={url} method="delete" class="nav-link"><%= label %></.link>
            </li>
          <% {:dropdown, {label, urls}} -> %>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <%= label %>
              </a>
              <ul class="dropdown-menu">
                <%= for {link_type, {label, url}} <- urls do %>
                  <li>
                    <.link :if={link_type == :link} navigate={url} class="dropdown-item"><%= label %></.link>
                    <.link :if={link_type == :href} href={url} class="dropdown-item"><%= label %></.link>
                  </li>
                <% end %>
              </ul>
            </li>
          <% {:offcanvas_icon_link, {icon, target}} -> %>
            <li class="nav-item">
              <button class="btn" type="button" data-bs-toggle="offcanvas" data-bs-target={target} aria-controls="offcanvasExample">
                <.icon name={icon} />
              </button>
            </li>
        <% end %>
      <% end %>
    </ul>
    """
  end

  def toolbar(assigns) do
    ~H"""
    <nav id="toolbar-component" role="navigation" class="navbar navbar-expand">
      <div class="container-fluid">
        <div class="navbar-nav mr-auto">
          <span :if={assigns[:title]} class="navbar-text">
            <h1><%= @title %></h1>
          </span>
        </div>

        <%= if assigns[:search] do %>
          <.live_component
            module={SearchForm}
            id="search_form"
            search={@search}
            matches={assigns[:matches] || []} />
        <% end %>

        <ul class="navbar-nav ml-auto">
          <li :if={assigns[:links]} class="nav-item dropdown">
            <.menu_dropdown
              icon="cog"
              id="object_menu"
              links={@links} />
          </li>
        </ul>
      </div>
    </nav>
    """
  end

  def menu_dropdown(assigns) do
    ~H"""
    <div class="dropdown">
      <button class="nav-link dropdown-toggle dropdown-admin"
        data-bs-toggle="dropdown"
        aria-haspopup="true"
        aria-expanded="false"
      >
        <.icon :if={assigns[:icon]} name={"fa-#{assigns[:icon]}"} class="text-danger"/>
        <%= assigns[:title] || gettext("Menu")%>
      </button>
      <div class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
        <%= for link <- @links do %>
          <%= if link == :divider do %>
            <div class="dropdown-divider"></div>
          <% else %>
            <%= case link do %>
              <% {:patch, {label, url}} -> %>
                <.link patch={url} class="nav-link"><%= label %></.link>
              <% {:link, {label, url}} -> %>
                <.link navigate={url} class="nav-link"><%= label %></.link>
              <% {:href, {label, url}} -> %>
                <.link href={url} class="nav-link"><%= label %></.link>
            <% end %>
          <% end %>
        <% end %>
      </div>
    </div>
    """
  end
end
