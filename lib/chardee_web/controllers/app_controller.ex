defmodule ChardeeWeb.AppController do
  use ChardeeWeb, :controller
  alias Chardee.API

  plug Guardian.Plug.EnsureAuthenticated, [handler: ChardeeWeb.AuthErrorHandler]

  def index(conn, _params) do
    apps = API.list_apps()
    render conn, "index.html", apps: apps
  end

  def new(conn, _params) do
    changeset = API.change_app(%API.App{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"app" => app_params}) do
    user = Guardian.Plug.current_resource(conn)
    case API.create_app(app_params, user) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "App created successfully.")
        |> redirect(to: app_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end

  end
end
