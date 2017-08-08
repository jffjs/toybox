defmodule Chardee.Repo.Migrations.CreateApps do
  use Ecto.Migration

  def change do
    create table(:apps) do
      add :name, :string
      add :api_key, :string
      add :user_id,
        references(:users, on_delete: :delete_all),
        null: false

      timestamps()
    end

    create unique_index(:apps, [:api_key])
    create index(:apps, [:user_id])
  end
end
