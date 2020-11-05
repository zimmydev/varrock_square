defmodule VarrockSquare.Accounts.User do
  @moduledoc """
  This module represents a User schema.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  schema "users" do
    field :username, :string
    field :role, :string, default: "user"
    field :email, :string
    field :rsn, :string
    field :has_avatar, :boolean, default: false
    field :bio, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    # TODO Potential for future 2-factor authentication (see: shorturl.at/mAHX2)
    field :has_2fa, :boolean, default: false
    timestamps()
  end

  def simple_changeset(user, params) do
    user
    |> cast(params, [:username, :email, :rsn, :has_avatar, :bio])
    |> validate_required([:username, :email])
    |> unique_constraint([:username, :email, :rsn])
    |> validate_length(:username, max: 20)
    |> validate_length(:email, min: 6, max: 320)
    |> validate_length(:rsn, max: 12)
    |> validate_length(:bio, max: 4096)
  end

  def registration_changeset(user, params) do
    user
    |> simple_changeset(params)
    |> cast(params, [:password, :has_2fa])
    |> validate_required([:password])
    # NOTE Won't be required for a login flow, so perhaps do this conditionally
    # |> validate_confirmation(:password, required: true, message: "password fields do not match")
    |> validate_length(:password, min: 6, max: 100)
    |> hash_password()
  end

  def role_changeset(user, params) do
    user
    |> cast(params, [:role])
    |> validate_required([:role])
    |> validate_inclusion(:role, ~w[user premium_user mod admin])
  end

  defp hash_password(changeset) do
    case changeset do
      # Only hash the password for a valid changeset
      %Changeset{valid?: true, changes: %{password: pwd}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pwd))

      _invalid_changeset ->
        changeset
    end
  end
end
