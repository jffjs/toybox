defmodule ChardeeWeb.AuthErrorHandler do
  use ChardeeWeb, :controller

  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, "Authentication require")
    |> redirect(to: "/")
  end
end
