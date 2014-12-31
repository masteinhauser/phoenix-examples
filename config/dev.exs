use Mix.Config

config :frontend, Frontend.Endpoint,
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true

# Enables code reloading for development
config :frontend, :code_reloader, true
