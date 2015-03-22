# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :frontend, Frontend.Endpoint,
  url: [host: "localhost"],
  http: [port: {:system, "PORT"}],
  secret_key_base: "LQG7Q1$VS1=FFGFV_7HY@EP+Y2ED29I72P!GI^JD=I3LC0+&X9M$N=%L89S4U(*G%C1#4!!1Y668UBO2",
  debug_errors: false,
  pubsub: [name: Frontend.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
