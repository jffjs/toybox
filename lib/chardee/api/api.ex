defmodule Chardee.API do
  @moduledoc """
  The API context.
  """

  import Ecto.Query, warn: false
  alias Chardee.Repo

  alias Chardee.API.APICredential

  @doc """
  Returns the list of api_credentials.

  ## Examples

      iex> list_api_credentials()
      [%APICredential{}, ...]

  """
  def list_api_credentials do
    Repo.all(APICredential)
  end

  @doc """
  Gets a single api_credential.

  Raises `Ecto.NoResultsError` if the Api credential does not exist.

  ## Examples

      iex> get_api_credential!(123)
      %APICredential{}

      iex> get_api_credential!(456)
      ** (Ecto.NoResultsError)

  """
  def get_api_credential!(id), do: Repo.get!(APICredential, id)

  @doc """
  Gets a single api credential by api key

  Returns `nil` if the APICredential does not exist.
  end

  ## Examples

      iex> get_api_credential_by_api_key("abcdef123")
      %APICredential{}

      iex> get_api_credential_by_api_key("def123abc")
      nil

  """
  def get_api_credential_by_api_key(api_key) do
    APICredential
    |> Repo.get_by(api_key: api_key)
    |> Repo.preload(:user)
  end

  @doc """
  Creates a api_credential.

  ## Examples

      iex> create_api_credential(%{field: value})
      {:ok, %APICredential{}}

      iex> create_api_credential(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_api_credential(attrs \\ %{}) do
    %APICredential{}
    |> APICredential.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a api_credential.

  ## Examples

      iex> update_api_credential(api_credential, %{field: new_value})
      {:ok, %APICredential{}}

      iex> update_api_credential(api_credential, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_api_credential(%APICredential{} = api_credential, attrs) do
    api_credential
    |> APICredential.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a APICredential.

  ## Examples

      iex> delete_api_credential(api_credential)
      {:ok, %APICredential{}}

      iex> delete_api_credential(api_credential)
      {:error, %Ecto.Changeset{}}

  """
  def delete_api_credential(%APICredential{} = api_credential) do
    Repo.delete(api_credential)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking api_credential changes.

  ## Examples

      iex> change_api_credential(api_credential)
      %Ecto.Changeset{source: %APICredential{}}

  """
  def change_api_credential(%APICredential{} = api_credential) do
    APICredential.changeset(api_credential, %{})
  end
end
