defmodule PhxRsbuildWeb.SearchForm do
  use PhxRsbuildWeb, :live_component
  require Logger

  import PhxRsbuildWeb.CoreComponents, only: [icon: 1]

  alias PhxRsbuildWeb.Schemaless.Search

  @impl true
  def render(assigns) do
    ~H"""
    <form id={@id}
      class="d-flex"
      phx-change="suggest"
      phx-submit="search"
      phx-target={@myself} >
      <input
        class="form-control me-2"
        type="search"
        name="search"
        value={@search}
        placeholder="Search"
        autofocus
        autocomplete="off"
        phx-debounce="300"
        list="matches" />

      <datalist :if={assigns[:matches]} id="matches">
        <option :for={match <- @matches} value={match}><%= match %></option>
      </datalist>

      <button type="submit" class="btn btn-sm" title={gettext("Search")} >
        <.icon name="fa-search" />
      </button>
    </form>
    """
  end

  @impl true
  def handle_event("search", params, socket) do
    parse_params(params, socket)
  end

  def handle_event(event, params, socket) do
    Logger.info("#{__MODULE__} received unknown event #{event} with params #{inspect(params)}")
    {:noreply, socket}
  end

  defp parse_params(params, socket) do
    case Search.parse(params) do
      {:ok, opts} ->
        send(self(), {:update, opts})
        {:noreply, socket}
      {:error, _changeset} ->
        {:noreply, socket}
    end
  end
end
