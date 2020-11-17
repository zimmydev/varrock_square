import Config

config :pbkdf2_elixir,
  rounds: 5

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :varrock_square, VarrockSquare.Repo,
  username: "zimmy",
  password: "",
  database: "varrock_square_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :varrock_square, VarrockSquareWeb.Endpoint,
  https: [
    port: 4002,
    cipher_suite: :strong,
    keyfile: "priv/cert/selfsigned_key.pem",
    certfile: "priv/cert/selfsigned.pem"
  ],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
