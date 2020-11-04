defmodule VarrockSquareWeb.ElmController do
  use VarrockSquareWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
