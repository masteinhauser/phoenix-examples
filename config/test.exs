use Mix.Config

config :frontend, Frontend.Endpoint,
  http: [port: System.get_env("PORT") || 4001],
  catch_errors: false
