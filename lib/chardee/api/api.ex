defmodule Chardee.API do
  @moduledoc """
  The API context.
  """

  import Ecto.Query, warn: false
  alias Chardee.Repo

  alias Chardee.Accounts
  alias Chardee.API.App

  @doc """
  Returns the list of apps.

  ## Examples

      iex> list_apps()
      [%App{}, ...]

  """
  def list_apps do
    Repo.all(App)
  end

  @doc """
  Gets a single app.

  Raises `Ecto.NoResultsError` if the Api credential does not exist.

  ## Examples

      iex> get_app!(123)
      %App{}

      iex> get_app!(456)
      ** (Ecto.NoResultsError)

  """
  def get_app!(id), do: Repo.get!(App, id)

  @doc """
  Gets a single api credential by api key

  Returns `nil` if the App does not exist.
  end

  ## Examples

      iex> get_app_by_api_key("abcdef123")
      %App{}

      iex> get_app_by_api_key("def123abc")
      nil

  """
  def get_app_by_api_key(api_key) do
    App
    |> Repo.get_by(api_key: api_key)
    |> Repo.preload(:user)
  end

  @doc """
  Creates a app.

  ## Examples

      iex> create_app(%{field: value})
      {:ok, %App{}}

      iex> create_app(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_app(attrs \\ %{}, user) do
    %App{user: user, api_key: generate_api_key()}
    |> App.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a app.

  ## Examples

      iex> update_app(app, %{field: new_value})
      {:ok, %App{}}

      iex> update_app(app, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_app(%App{} = app, attrs) do
    app
    |> App.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a App.

  ## Examples

      iex> delete_app(app)
      {:ok, %App{}}

      iex> delete_app(app)
      {:error, %Ecto.Changeset{}}

  """
  def delete_app(%App{} = app) do
    Repo.delete(app)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking app changes.

  ## Examples

      iex> change_app(app)
      %Ecto.Changeset{source: %App{}}

  """
  def change_app(%App{} = app) do
    App.changeset(app, %{})
  end

  @doc """
  Generates an API Key.
  """
  def generate_api_key() do
    :crypto.hash(:md5, Ecto.UUID.generate())
    |> Base.encode32(padding: false)
    |> String.downcase()
  end

  @doc """
  Authenticate app access by email and password.
  """
  def authenticate_app_by_email_password(api_key, email, password) do
    with {:ok, _} <- Accounts.authenticate_by_email_password(email, password),
         %App{} = app <- get_app_by_api_key(api_key) do
      {:ok, app}
    else
      :unauthorized -> {:error, :unauthorized}
      nil -> {:error, :invalid_api_key}
    end
  end
end
