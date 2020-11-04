defmodule VarrockSquare.Repo do
  use Ecto.Repo,
    otp_app: :varrock_square,
    adapter: Ecto.Adapters.Postgres
end
