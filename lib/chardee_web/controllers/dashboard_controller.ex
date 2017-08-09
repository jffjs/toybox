defmodule ChardeeWeb.DashboardController do
  use ChardeeWeb, :controller
  alias Chardee.API

  plug Guardian.Plug.EnsureAuthenticated, [handler: ChardeeWeb.AuthErrorHandler]

  def index(conn, _params) do
    apps = API.list_apps()
    render conn, "index.html", apps: apps
  end

  def new_app(conn, _params) do
    changeset = API.change_app(%API.App{})
    render conn, "new_app.html", changeset: changeset
  end

  def create_app(conn, %{"app" => app_params}) do
    user = Guardian.Plug.current_resource(conn)
    case API.create_app(app_params, user) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "App created successfully.")
        |> redirect(to: dashboard_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new_app.html", changeset: changeset)
    end

  end
end
