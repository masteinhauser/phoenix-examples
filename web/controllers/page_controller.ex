defmodule Frontend.PageController do
  use Phoenix.Controller

  plug :put_layout, "application.html"
  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
  def hello(conn, _params) do
    render conn, "hello.html"
  end
  def video(conn, _params) do
    render conn, "video.html"
  end
  def bytes(conn, _params) do
    render conn, "bytes.html"
  end
  def upload(conn, _params) do
    render conn, "upload.html"
  end
  def comment(conn, _params) do
    render conn, "comment.html"
  end

  def show(conn, %{"page" => "admin"}) do
    redirect conn, to: Router.page_path(page: "unauthorized")
  end
  def show(conn, %{"page" => page}) do
    render conn, "hello.html"
  end

  def not_found(conn, _params) do
    render conn, "not_found.html"
  end

  def error(conn, _params) do
    render conn, "error.html"
  end
end
