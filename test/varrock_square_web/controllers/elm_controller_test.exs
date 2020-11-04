defmodule VarrockSquareWeb.ElmControllerTest do
  use VarrockSquareWeb.ConnCase

  @elm_app_div ~s[<div id="elm-app-mount"></div>]

  test "Elm is served on root route", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ @elm_app_div
  end

  test "Elm is served on another random route", %{conn: conn} do
    conn = get(conn, "/users")
    assert html_response(conn, 200) =~ @elm_app_div
  end
end
