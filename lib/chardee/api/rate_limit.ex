defmodule Chardee.API.RateLimit do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chardee.Accounts.User
  alias Chardee.API.App
  alias Chardee.API.RateLimit


  schema "rate_limits" do
    field :limit, :integer
    field :current, :integer, default: 0
    field :period, :string
    belongs_to :user, User
    has_many :apps, App

    timestamps()
  end

  @doc false
  def changeset(%RateLimit{} = rate_limit, attrs) do
    rate_limit
    |> cast(attrs, [:limit, :current, :period])
    |> validate_required([:limit, :current, :period])
  end
end
