defmodule Frontend.Router do
  use Phoenix.Router

  plug Plug.Static, at: "/static", from: :frontend
  get "/", Frontend.PageController, :index, as: :page
  get "/hello", Frontend.PageController, :hello
  get "/video", Frontend.PageController, :video
  get "/bytes", Frontend.PageController, :bytes

  get "/video/:video", Frontend.VideoController, :send
  get "/stream/:video", Frontend.VideoController, :stream
  get "/bytes/:video", Frontend.VideoController, :bytes
end
