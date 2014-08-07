defmodule Frontend.PageController do
  use Phoenix.Controller

  def index(conn, _params) do
    render conn, "index"
  end
  def hello(conn, _params) do
    render conn, "hello"
  end
  def video(conn, _params) do
    render conn, "video"
  end
  def bytes(conn, _params) do
    render conn, "bytes"
  end
  def upload(conn, _params) do
    render conn, "upload"
  end

  def show(conn, %{"page" => "admin"}) do
    redirect conn, Router.page_path(page: "unauthorized")
  end
  def show(conn, %{"page" => page}) do
    render conn, "hello"
  end
end
