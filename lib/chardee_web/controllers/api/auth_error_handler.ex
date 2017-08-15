defmodule ChardeeWeb.API.AuthErrorHandler do
  use ChardeeWeb, :controller
  alias ChardeeWeb.API.ErrorView

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> render(ErrorView, :"401", message: "Authentication required.")
  end
end
