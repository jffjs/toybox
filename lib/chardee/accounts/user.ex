defmodule Chardee.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chardee.Accounts.{User, Credential}
  alias Chardee.API.APICredential


  schema "users" do
    field :name, :string
    has_one :credential, Credential
    has_many :api_credentials, APICredential

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
