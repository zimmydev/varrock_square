defmodule VarrockSquare.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    # Create a table without a default primary key; we'll use the username as a primary key.
    create table(:users, primary_key: false) do
      add :username, :string, null: false, size: 20, primary_key: true
      add :email, :string, null: false, size: 320
      add :password_hash, :string, null: false
      add :role, :string, null: false, default: "user", size: 20
      add :has_2fa, :boolean, null: false, default: false
      add :has_avatar, :boolean, null: false, default: false
      add :rsn, :string, size: 12
      add :bio, :string, size: 4000
      timestamps()
    end

    # NOTE The primary key (username) is a unique index by default
    create unique_index(:users, [:email])
    create unique_index(:users, [:rsn])
  end
end
