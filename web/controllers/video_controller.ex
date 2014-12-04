defmodule Frontend.VideoController do
  use Phoenix.Controller
  plug :action

  # For a list of what plugs are already included
  # Check: https://github.com/phoenixframework/phoenix/blob/master/lib/phoenix/router.ex
  # To disable loading all automated plugs, set `parsers: false` in mix.exs

  def send(conn, %{"video" => video}) do
    video = "#{System.cwd}/web/files/#{video}"
    {:ok, file_info} = File.stat(video)

    content_type = Plug.MIME.path(video)
    {:ok, data} = File.read(video)
    send_response conn, 200, content_type, data
  end

  def stream(conn, %{"video" => video}) do
    video = "#{System.cwd}/web/files/#{video}"
    {:ok, file_info} = File.stat(video)

    content_type = Plug.MIME.path(video)
    conn = put_resp_content_type(conn, content_type, nil)
    conn = send_chunked(conn, 200)

    File.stream!(video, [:read], 1024)
    |> Enum.reduce(conn, fn data, conn -> chunk_ok(conn, data) end)
  end

  def bytes(conn, %{"video" => video}) do
    path = "web/files/"
    conn
    |> PlugByteServe.call([path: path, file: video])
    |> send_resp()
  end

  def bytes_head(conn, %{"video" => video}) do
    path = "web/files/"
    conn
    |> PlugByteServe.call([path: path, file: video, limit: 0])
    |> send_resp()
  end

  def upload(conn, %{"file" => file, "name" => name}) do
    {:ok, bytes_copied} = File.copy(file.path, "#{System.cwd}/web/files/#{file.filename}")
    content_type = Plug.MIME.path(file.filename)
    render conn, "bytes", video: file.filename, content_type: content_type
  end

  def download(conn, %{"video" => video}) do
    video = "#{System.cwd}/web/files/#{video}"
    {:ok, file_info} = File.stat(video)

    content_type = Plug.MIME.path(video)
    {:ok, data} = File.read(video)
    send_file conn, 200, video
  end

  defp chunk_ok(conn, data) do
    {:ok, conn} = chunk(conn, data)
    conn
  end
end

