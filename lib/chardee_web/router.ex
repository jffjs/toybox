defmodule ChardeeWeb.Router do
  use ChardeeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug :logged_in?
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChardeeWeb do
    pipe_through [:browser, :browser_auth ] # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete],
                                              singleton: true
    get "/signup", UserController, :register
    get "/login", SessionController, :new
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChardeeWeb do
  #   pipe_through :api
  # end

  defp logged_in?(conn, _) do
    case Guardian.Plug.current_resource(conn) do
      %Chardee.Accounts.User{} ->
        assign(conn, :logged_in?, true)
      _ ->
        assign(conn, :logged_in?, false)
    end
  end
end
