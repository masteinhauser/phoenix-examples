defmodule Frontend.Endpoint do
  use Phoenix.Endpoint, otp_app: :frontend

  plug Plug.Static,
    at: "/", from: :frontend

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_frontend_key",
    signing_salt: "MdZQyfJz",
    encryption_salt: "DGr5WYVu"

  plug :router, Frontend.Router
end
