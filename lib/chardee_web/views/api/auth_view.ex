defmodule ChardeeWeb.API.AuthView do
  use ChardeeWeb, :view

  def render("authenticate.json", %{jwt: jwt, exp: exp}) do
    %{token: jwt, expires: exp}
  end

  def render("error.json", %{message: message}) do
    %{error: message}
  end
end
