defmodule LinklyWeb.UrlController do
  use LinklyWeb, :controller

  alias Linkly.Links
  alias Linkly.Links.Url

  action_fallback LinklyWeb.FallbackController

  def index(conn, _params) do
    urls = Links.list_urls()
    render(conn, "index.json", urls: urls)
  end

  def create(conn, %{"url" => url_params}) do
    url_params =
      if is_nil(url_params["short"]) do
        Map.put(url_params, "short", Base.url_encode64(url_params["long"]))
      else
        url_params
      end

    with {:ok, %Url{} = url} <- Links.create_url(url_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.url_path(conn, :show, url))
      |> render("show.json", url: url)
    end
  end

  def show(conn, %{"id" => id}) do
    url = Links.get_url!(id)
    render(conn, "show.json", url: url)
  end

  def update(conn, %{"id" => id, "url" => url_params}) do
    url = Links.get_url!(id)

    with {:ok, %Url{} = url} <- Links.update_url(url, url_params) do
      render(conn, "show.json", url: url)
    end
  end

  def delete(conn, %{"id" => id}) do
    url = Links.get_url!(id)

    with {:ok, %Url{}} <- Links.delete_url(url) do
      send_resp(conn, :no_content, "")
    end
  end
end
