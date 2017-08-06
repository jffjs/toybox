defmodule Chardee.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chardee.Accounts.{Credential, User}


  schema "credentials" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Credential{} = credential, attrs) do
    credential
    |> cast(attrs, [:email, :password, :password_confirmation])
    |> validate_required([:email, :password, :password_confirmation])
    |> validate_length(:password, min: 8, max: 100)
    |> validate_format(:email, ~r/@/, message: "should be valid email")
    |> validate_confirmation(:password, message: "does not match password")
    |> hash_password
    |> unique_constraint(:email)
  end

  defp hash_password(%Ecto.Changeset{valid?: true,
                                     changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Bcrypt.add_hash(password))
  end
  defp hash_password(changeset), do: changeset
end
