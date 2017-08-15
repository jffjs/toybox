defmodule ChardeeWeb.API.TestController do
  use ChardeeWeb, :controller
  plug Guardian.Plug.EnsureAuthenticated, handler: ChardeeWeb.API.AuthErrorHandler

  def index(conn, _) do
    render conn, "index.json", %{}
  end
end
