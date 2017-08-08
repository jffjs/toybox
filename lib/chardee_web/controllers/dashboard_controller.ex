defmodule ChardeeWeb.DashboardController do
  use ChardeeWeb, :controller
  alias Chardee.API.App

  def index(conn, _params) do
    apps = API.list_apps()
    render conn, "index.html", apps: apps
  end

  def new_app(conn, _params) do
    changeset = API.change_app(%App{})
    render conn, "new_app.html", changeset: changeset
  end

  def create_app(conn, params) do
  end
end
