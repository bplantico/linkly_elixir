defmodule LinklyWeb.Router do
  use LinklyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LinklyWeb do
    pipe_through :api

    resources "/urls", UrlController
  end
end
