defmodule Frontend.VideoController do
  use Phoenix.Controller

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
    video = "#{System.cwd}/web/files/#{video}"
    {:ok, file_info} = File.stat(video)

    hdr_range = get_req_header(conn, "range")

    case hdr_range do
      [] ->
        [range_type, range_start, range_end] = ["bytes", "0", "999"]
      _ ->
        [range_type, range_start, range_end] = String.split(List.last(hdr_range), ["=", "-"])
    end

    case range_end do
      "" ->
        range_end = "#{file_info.size - 1}"
      _ ->
        range_end
    end

    [range_start, range_end] = Enum.map([range_start, range_end], fn(x) -> String.to_integer(x) end)
    range_limit = range_end - range_start + 1

    {:ok, video_device} = :file.open(video, [:read, :binary])
    {:ok, video_pos} = :file.position(video_device, range_start)
    {:ok, data} = :file.read(video_device, range_limit)

    content_type = Plug.MIME.path(video)
    conn
    |> resp(206, data)
    |> put_resp_header("accept-ranges", "bytes")
    |> put_resp_header("content-type", content_type)
    |> put_resp_header("content-length", "#{range_limit}")
    |> put_resp_header("content-range", "bytes #{range_start}-#{range_end}/#{file_info.size}")
    |> send_resp()
  end

  def bytes_head(conn, %{"video" => video}) do
    video = "#{System.cwd}/web/files/#{video}"
    {:ok, file_info} = File.stat(video)

    content_type = Plug.MIME.path(video)
    conn
    |> resp(200, "")
    |> put_resp_header("accept-ranges", "bytes")
    |> put_resp_header("content-type", content_type)
    |> put_resp_header("content-length", "#{file_info.size}")
    |> send_resp()
  end

  def upload(conn, %{"file" => file, "name" => name}) do

    # {:ok, file} =
    send_response(conn, 200, "text/plain", "Upload Received: file => #{file.filename}, name => #{name}")
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

