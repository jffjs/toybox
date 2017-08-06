defmodule ChardeeWeb.AuthHelpers do
  @moduledoc """
  Conveniences for handling authentication and authorization within views.
  """

  @doc """
  Checks if a user is currently logged in.
  """
  def logged_in?(conn) do
    case Guardian.Plug.current_resource(conn) do
      %Chardee.Accounts.User{} ->
        true
      _ ->
        false
    end
  end
end
