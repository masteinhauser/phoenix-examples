defmodule Frontend.VideoController do
  use Phoenix.Controller

  def send(conn, %{"video" => video}) do
    video = "/Users/myles/code/github/masteinhauser/vc-frontend/web/files/sample.mp4"
    content_type = Plug.MIME.path(video)
    # {:ok, data} = File.stat(video)
    {:ok, data} = File.read(video)
    send_response conn, 200, content_type, data
  end

  def stream(conn, %{"video" => video}) do
    video = "/Users/myles/code/github/masteinhauser/vc-frontend/web/files/sample.mp4"
    content_type = Plug.MIME.path(video)
    put_resp_content_type conn, content_type

    # {:ok, data} = File.stat(video)
    conn = send_chunked conn, 206


    File.stream! video, [:read], 10240
    |> Enum.each fn(data) ->
      { :ok, conn } = chunk conn, data
    end
    { :ok, conn } = chunk conn, 0
  end

  def download(conn, %{"video" => video}) do
    video = "/Users/myles/code/github/masteinhauser/vc-frontend/web/files/sample.mp4"
    content_type = Plug.MIME.path(video)
    # {:ok, data} = File.stat(video)
    {:ok, data} = File.read(video)
    #send_response conn, 200, content_type, data
    send_file conn, 200, video
  end
end
