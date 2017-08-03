defmodule ToyboxWeb.Router do
  use ToyboxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :logged_in?
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ToyboxWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/signup", PageController, :signup
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete],
                                              singleton: true
    get "/login", SessionController, :new
  end

  scope "/cms", ToyboxWeb.CMS, as: :cms do
    pipe_through [:browser, :authenticate_user]

    resources "/pages", PageController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ToyboxWeb do
  #   pipe_through :api
  # end

  defp logged_in?(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        assign(conn, :logged_in?, false)
      user_id ->
        assign(conn, :logged_in?, true)
    end
  end

  defp authenticate_user(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      user_id ->
        assign(conn, :current_user, Toybox.Accounts.get_user!(user_id))
    end
  end
end
