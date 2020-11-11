defmodule VarrockSquare.Repo.Migrations.CreateAuthTokens do
  use Ecto.Migration

  def change do
    create table(:auth_tokens) do
      add :token, :text, null: false
      add :revoked, :boolean, default: false, null: false
      add :revoked_at, :utc_datetime
      add :assignee, references(:users, column: :username, type: :string), null: false
      timestamps()
    end

    # NOTE The primary key (auth_token_id) is a unique index by default
    create unique_index(:auth_tokens, [:token])
    create index(:auth_tokens, [:assignee])
  end
end
