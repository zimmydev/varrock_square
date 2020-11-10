defmodule VarrockSquareWeb.Router do
  use VarrockSquareWeb, :router

  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ~w[html]

    # TODO Removing templates is a step towards webpack HTML generation (affords us bundle hashing); work towards serving a static index.html!
    # plug :put_layout, false
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ~w[json]
  end

  scope "/dashboard" do
    pipe_through :browser

    live_dashboard "/", metrics: VarrockSquareWeb.Telemetry
  end

  scope "/api", VarrockSquareWeb do
    pipe_through :api
  end

  scope "/", VarrockSquareWeb do
    pipe_through :browser

    get "/*path", ElmController, :index
  end
end
