defmodule Chardee.Repo.Migrations.AddRateLimitIdColumnToApps do
  use Ecto.Migration

  def change do
    alter table(:apps) do
      add :rate_limit_id, references(:rate_limits), null: false
    end
  end
end
