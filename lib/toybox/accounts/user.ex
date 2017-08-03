defmodule Toybox.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Toybox.Accounts.{User, Credential}


  schema "users" do
    field :username, :string
    field :name, :string
    has_one :credential, Credential

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> unique_constraint(:username)
  end
end
