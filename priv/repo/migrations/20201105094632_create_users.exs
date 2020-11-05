defmodule VarrockSquare.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    # Create a table without the default user_id primary key; we'll use the username as the unique primary key
    create table(:users, primary_key: false) do
      add :username, :string, null: false, size: 20, primary_key: true
      # NOTE A role should be one of ~w[user premium_user mod admin]
      add :role, :string, null: false, default: "user"
      add :email, :string, null: false, size: 320
      add :rsn, :string, size: 12
      add :has_avatar, :boolean, null: false, default: false
      add :bio, :string, size: 4096
      add :password_hash, :string, null: false
      add :has_2fa, :boolean, null: false, default: false
      timestamps()
    end

    create unique_index(:users, [:username, :email, :rsn])
  end
end
