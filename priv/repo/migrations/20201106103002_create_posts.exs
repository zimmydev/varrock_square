defmodule VarrockSquare.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    # Create a table without a default primary key; we'll use the slug as a primary key.
    create table(:posts, primary_key: false) do
      add :slug, :string, null: false, primary_key: true
      add :is_published, :boolean, null: false, default: false
      add :title, :string, null: false
      add :body, :text, null: false, default: ""
      add :author, references(:users, column: :username, type: :string), null: false
      timestamps()
    end

    # NOTE The primary key (slug) is a unique index by default
    create index(:posts, [:author])
  end
end
