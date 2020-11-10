use Mix.Config

# Configure your database
config :varrock_square, VarrockSquare.Repo,
  username: "zimmy",
  password: "",
  database: "varrock_square_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# config :varrock_square, VarrockSquare.Accounts.Guardian,
#   issuer: "varrock_square",
#   secret_key: "xhPbimJRPU0PFTq8Snx4Wo4CaXnoTdXCO0cktFzltmj3EWF6WNGGLFpWdOzVoi58"

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :varrock_square, VarrockSquareWeb.Endpoint,
  https: [
    port: 4001,
    cipher_suite: :strong,
    keyfile: "priv/cert/selfsigned_key.pem",
    certfile: "priv/cert/selfsigned.pem"
  ],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

# Watch static and templates for browser reloading.
config :varrock_square, VarrockSquareWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpe?g|gif|svg|woff2?)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/varrock_square_web/(live|views)/.*(ex)$",
      ~r"lib/varrock_square_web/templates/.*(eex)$"
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
