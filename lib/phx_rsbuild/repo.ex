defmodule PhxRsbuild.Repo do
  use Ecto.Repo,
    otp_app: :phx_rsbuild,
    adapter: Ecto.Adapters.Postgres
end
