defmodule Chardee.Repo.Migrations.CreateRateLimits do
  use Ecto.Migration

  def change do
    create table(:rate_limits) do
      add :limit, :integer
      add :current, :integer
      add :period, :string
      add :user_id,
        references(:users, on_delete: :delete_all),
        null: false

      timestamps()
    end
  end
end
