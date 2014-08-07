defmodule Frontend.CommentController do
  use Phoenix.Controller
  plug Plug.Parsers, parsers: [:urlencoded, :multipart], limit: 1_000_000_000

  def comment(conn, %{"video" => video, "comment" => comment}) do

    # {:ok, file} =
    send_response(conn, 200, "text/plain", "Comment Received: video => #{video}, comment => #{comment}")
  end
end

