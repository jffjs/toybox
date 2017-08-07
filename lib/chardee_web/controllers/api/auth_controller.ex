defmodule ChardeeWeb.API.AuthController do
  require Logger
  use ChardeeWeb, :controller
  alias Chardee.API
  alias Chardee.API.APICredential

  def authenticate(conn, %{"api_key" => api_key}) do
    case API.get_api_credential_by_api_key(api_key) do
      %APICredential{user: user} ->
        IO.puts inspect(user)
        new_conn = Guardian.Plug.api_sign_in(conn, user)
        jwt = Guardian.Plug.current_token(new_conn)
        Logger.info "jwt: #{jwt}"
        {:ok, claims} = Guardian.Plug.claims(new_conn)
        exp = Map.get(claims, "exp")

        new_conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> put_resp_header("x-expires", "#{exp}")
        |> render("authenticate.json", jwt: jwt, exp: exp)
      nil ->
        conn
        |> put_status(401)
        |> render("error.json", message: "Unable to authenticate")
    end
  end
end
