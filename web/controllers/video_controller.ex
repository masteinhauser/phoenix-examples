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
    conn = put_resp_content_type(conn, content_type, nil)

    # {:ok, data} = File.stat(video)
    conn = send_chunked(conn, 200)


    {:ok, file_info} = File.stat(video)
    # conn = put_resp_header(conn, "Content-Range", "bytes #{acc}-1024/#{file_info.size}")


    File.stream!(video, [:read], 1024)
    |> Enum.reduce(conn, fn data, conn -> chunk_ok(conn, data) end)
  end

  def download(conn, %{"video" => video}) do
    video = "/Users/myles/code/github/masteinhauser/vc-frontend/web/files/sample.mp4"
    content_type = Plug.MIME.path(video)
    # {:ok, data} = File.stat(video)
    {:ok, data} = File.read(video)
    #send_response conn, 200, content_type, data
    send_file conn, 200, video
  end

  defp chunk_ok(conn, data) do
    {:ok, conn} = chunk(conn, data)
    conn
  end
end

