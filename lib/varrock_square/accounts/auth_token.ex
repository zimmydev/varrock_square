defmodule VarrockSquare.Accounts.AuthToken do
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias VarrockSquare.{Accounts}

  schema "auth_tokens" do
    field :token, :string
    field :revoked, :boolean, default: false
    field :revoked_at, :utc_datetime
    # AuthTokens are owned by a user
    belongs_to :user, Accounts.User, foreign_key: :assignee, references: :username, type: :string
    # Token creation & last-modified date
    timestamps()
  end

  @doc false
  def changeset(auth_token = %AuthToken{}, attrs) do
    auth_token
    |> cast(attrs, [:token])
    |> validate_required([:token])
    |> unique_constraint(:token)
  end
end
