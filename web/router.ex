defmodule Frontend.Router do
  use Phoenix.Router

  plug Plug.Static, at: "/static", from: :frontend
  get "/", Frontend.PageController, :index, as: :page
  get "/hello", Frontend.PageController, :hello
  get "/video", Frontend.PageController, :video

  get "/video/:video", Frontend.VideoController, :send
  get "/stream/:video", Frontend.VideoController, :stream
  # get "/stream/:video", Frontend.VideoController, :send
end
