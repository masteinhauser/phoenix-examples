defmodule Frontend.PageController do
  use Phoenix.Controller

  plug :action

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
  def comment(conn, _params) do
    render conn, "comment"
  end

  def show(conn, %{"page" => "admin"}) do
    redirect conn, Router.page_path(page: "unauthorized")
  end
  def show(conn, %{"page" => page}) do
    render conn, "hello"
  end

  def not_found(conn, _params) do
    render conn, "not_found"
  end

  def error(conn, _params) do
    render conn, "error"
  end
end
