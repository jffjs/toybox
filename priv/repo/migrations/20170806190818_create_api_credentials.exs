defmodule Chardee.Repo.Migrations.CreateApiCredentials do
  use Ecto.Migration

  def change do
    create table(:api_credentials) do
      add :app, :string
      add :api_key, :string
      add :api_secret, :string
      add :user_id,
        references(:users, on_delete: :delete_all),
        null: false

      timestamps()
    end

    create unique_index(:api_credentials, [:api_key])
    create index(:api_credentials, [:user_id])
  end
end
