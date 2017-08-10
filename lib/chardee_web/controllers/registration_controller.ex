defmodule ChardeeWeb.RegistrationController do
  use ChardeeWeb, :controller
  alias Chardee.Accounts
  alias Chardee.Accounts.User

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, "Welcome aboard!")
        |> redirect(to: "/")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
