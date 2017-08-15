defmodule ChardeeWeb.API.ErrorView do
  use ChardeeWeb, :view
  alias ChardeeWeb.API.ErrorHelpers

  def render("401.json", %{message: message}) do
    ErrorHelpers.error_json(message)
  end
end
