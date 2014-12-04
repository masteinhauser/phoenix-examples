# This file is responsible for configuring your application
use Mix.Config

# Note this file is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project.

config :phoenix, Frontend.Router,
  url: [host: "localhost"],
  http: [port: System.get_env("PORT")],
  https: false,
  secret_key_base: "LQG7Q1$VS1=FFGFV_7HY@EP+Y2ED29I72P!GI^JD=I3LC0+&X9M$N=%L89S4U(*G%C1#4!!1Y668UBO2",
  catch_errors: true,
  debug_errors: false,
  error_controller: Upgrade.PageController

# Session configuration
config :phoenix, Frontend.Router,
  session: [store: :cookie,
            key: "_frontend_key"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. Note, this must remain at the bottom of
# this file to properly merge your previous config entries.
import_config "#{Mix.env}.exs"
