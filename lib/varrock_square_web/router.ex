defmodule VarrockSquareWeb.Router do
  use VarrockSquareWeb, :router

  import Phoenix.LiveDashboard.Router

  alias VarrockSquare.Accounts

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

    plug Guardian.Plug.Pipeline,
      opt_app: :varrock_square,
      module: Accounts.Guardian,
      error_handler: Accounts.ErrorHandler

    plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
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
