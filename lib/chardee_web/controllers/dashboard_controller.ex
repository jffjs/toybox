defmodule ChardeeWeb.DashboardController do
  use ChardeeWeb, :controller
  alias Chardee.API

  plug Guardian.Plug.EnsureAuthenticated, [handler: ChardeeWeb.AuthErrorHandler]

end
