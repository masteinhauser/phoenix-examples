defmodule Frontend.Router do
  use Phoenix.Router

  plug Plug.Static, at: "/static", from: :frontend

  scope alias: Frontend do
    get "/", PageController, :index, as: :page
    get "/hello", PageController, :hello
    get "/video", PageController, :video
    get "/bytes", PageController, :bytes
    get "/upload", PageController, :upload
    get "/comment", PageController, :comment

    head "/bytes/:video", VideoController, :bytes_head

    get "/video/:video", VideoController, :send
    get "/stream/:video", VideoController, :stream
    get "/bytes/:video", VideoController, :bytes

    post "/upload", VideoController, :upload
    post "/comment", CommentController, :comment
  end
end
