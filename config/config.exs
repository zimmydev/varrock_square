# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :varrock_square,
  ecto_repos: [VarrockSquare.Repo]

# Configures the endpoint
config :varrock_square, VarrockSquareWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "13tv/DJ7kkfFzUU1VAOLlN5SKrsKpQze7CY4ggq0RZpQTUblAtxeg3O3Bu63V8MS",
  render_errors: [view: VarrockSquareWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: VarrockSquare.PubSub,
  live_view: [signing_salt: "nT7KcABC"]

config :varrock_square, VarrockSquare.Accounts.Guardian,
  issuer: "varrock_square",
  verify_issuer: true

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
