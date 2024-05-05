defmodule PhxRsbuildWeb.Schemaless.Search do
  import Ecto.Changeset

  @fields %{
    search: :string,
  }

  @default_values %{
    search: "",
  }

  def parse(params, values \\ @default_values) do
    {values, @fields}
    |> cast(params, Map.keys(@fields))
    |> apply_action(:insert)
  end

  def default_values(overrides \\ %{}), do: Map.merge(@default_values, overrides)

  def contains_search_values?(opts) do
    @fields
    |> Map.keys()
    |> Enum.any?(fn key -> Map.get(opts, key) end)
  end
end
