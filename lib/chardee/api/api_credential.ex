defmodule Chardee.API.APICredential do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chardee.Accounts.User
  alias Chardee.API.APICredential


  schema "api_credentials" do
    field :api_key, :string
    field :api_secret, :string
    field :app, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%APICredential{} = api_credential, attrs) do
    api_credential
    |> cast(attrs, [:app, :api_key, :api_secret])
    |> validate_required([:app, :api_key, :api_secret])
    |> unique_constraint(:api_key)
  end
end
