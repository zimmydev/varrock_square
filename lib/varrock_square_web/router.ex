defmodule VarrockSquareWeb.Router do
  use VarrockSquareWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]

    # TODO Removing templates is a step towards webpack HTML generation (affords us bundle hashing); work towards serving a static index.html!
    # plug :put_layout, false
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: VarrockSquareWeb.Telemetry
    end
  end

  scope "/api", VarrockSquareWeb do
    pipe_through :api
  end

  scope "/", VarrockSquareWeb do
    pipe_through :browser

    get "/*path", ElmController, :index
  end
end
