defmodule ChardeeWeb.API.AuthView do
  use ChardeeWeb, :view
  alias ChardeeWeb.API.ErrorHelpers

  def render("authenticate.json", %{jwt: jwt, exp: exp}) do
    %{token: jwt, expires: exp}
  end

  def render("error.json", %{message: message}) do
    ErrorHelpers.error_json(message)
  end
end
