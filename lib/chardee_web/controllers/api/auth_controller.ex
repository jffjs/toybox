defmodule ChardeeWeb.API.AuthController do
  use ChardeeWeb, :controller
  alias Chardee.API
  alias ChardeeWeb.API.ErrorView

  def authenticate(conn, %{"api_key" => api_key,
                           "username" => email,
                           "password" => password}) do
    case API.authenticate_app_by_email_password(api_key, email, password) do
      {:ok, %API.App{user: user}} ->
        new_conn = Guardian.Plug.api_sign_in(conn, user)
        jwt = Guardian.Plug.current_token(new_conn)
        {:ok, claims} = Guardian.Plug.claims(new_conn)
        exp = Map.get(claims, "exp")

        new_conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> put_resp_header("x-expires", "#{exp}")
        |> render("authenticate.json", jwt: jwt, exp: exp)
      {:error, _}->
        conn
        |> put_status(401)
        |> render(ErrorView, :"401", message: "Authentication required.")
    end
  end
end
