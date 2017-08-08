defmodule Chardee.API.App do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chardee.Accounts.User
  alias Chardee.API.App


  schema "app" do
    field :api_key, :string
    field :name, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%App{} = app, attrs) do
    app
    |> cast(attrs, [:name, :api_key])
    |> validate_required([:name, :api_key])
    |> unique_constraint(:api_key)
  end
end
