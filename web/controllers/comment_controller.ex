defmodule Frontend.CommentController do
  use Phoenix.Controller
  plug :put_layout, "application.html"
  plug :action
  plug Plug.Parsers, parsers: [:urlencoded, :multipart], limit: 1_000_000_000

  def comment(conn, %{"video" => video, "comment" => comment}) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp 200, "Comment Received: video => #{video}, comment => #{comment}"
  end
end

