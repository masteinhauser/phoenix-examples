use Mix.Config

config :phoenix, Frontend.Router,
  port: System.get_env("PORT"),
  ssl: false,
  code_reload: false,
  cookies: true,
  session_key: "_frontend_key",
  session_secret: "LQG7Q1$VS1=FFGFV_7HY@EP+Y2ED29I72P!GI^JD=I3LC0+&X9M$N=%L89S4U(*G%C1#4!!1Y668UBO2"

config :phoenix, :logger,
  level: :error

