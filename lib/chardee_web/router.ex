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
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", ChardeeWeb do
    pipe_through [:browser, :browser_auth ] # Use the default browser stack

    get "/", PageController, :index
    get "/signup", RegistrationController, :new
    get "/login", SessionController, :new

    resources "/apps", AppController
    resources "/users", UserController
    resources "/registrations", RegistrationController, only: [:new, :create],
                                                        singleton: true
    resources "/sessions", SessionController, only: [:new, :create, :delete],
                                              singleton: true
  end

  scope "/api", ChardeeWeb do
    pipe_through :api

    get "/auth/:api_key", API.AuthController, :authenticate
  end

  defp logged_in?(conn, _) do
    case Guardian.Plug.current_resource(conn) do
      %Chardee.Accounts.User{} ->
        assign(conn, :logged_in?, true)
      _ ->
        assign(conn, :logged_in?, false)
    end
  end
end
