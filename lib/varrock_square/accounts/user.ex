defmodule VarrockSquare.Accounts.User do
  @moduledoc """
  This module represents a user.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  alias VarrockSquare.Content.Post

  #### SCHEMA ####

  @primary_key {:username, :string, autogenerate: false}

  schema "users" do
    # Email can be used for password/2FA reset and login.
    field :email, :string
    # Password; only :password_hash is stored in the database.
    field :password, :string, virtual: true
    field :password_hash, :string
    # Age isn't collected, we just confirm the user is age 13+ at account creation time.
    field :age, :integer, virtual: true
    # The role describes user permissions across the site.
    field :role, :string, default: "user"
    # Two-factor authentication (see: shorturl.at/mAHX2).
    field :has_2fa, :boolean, default: false
    # Avatars are stored at a predictable public URL like [username].png so a flag is OK.
    field :has_avatar, :boolean, default: false
    # RSN is an optional OSRS in-game name.
    field :rsn, :string
    # User's bio, up to 4000 characters.
    field :bio, :string
    # A user owns posts
    has_many :posts, Post, foreign_key: :author
    # User join & last-modified date.
    timestamps()
  end

  #### CHANGESETS ####

  @doc """
  This changeset is used whenever a user needs to update their basic account information. It doesn't require any fields but accepts and validates `:email`, `:has_avatar` and `:bio` fields. `:email` must be unique.
  """
  @email_regex ~r|^[\w.%+-]+@[a-z0-9.-]+\.[a-z]{2,}$|ui
  def basic_info_changeset(user, params) do
    user
    |> cast(params, [:email, :has_avatar, :bio])
    |> validate_required([:email])
    |> validate_length(:email, min: 6, max: 320)
    |> validate_format(:email, @email_regex)
    |> unique_constraint(:email)
    |> validate_length(:bio, max: 4000)
  end

  @doc """
  This changeset is used whenever a user needs to update their email & password atomically. It requires that the `:email` and `:password` fields be set and valid, as well as requiring a matching `:password` confirmation field.
  """
  def auth_changeset(user, params) do
    user
    |> cast(params, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 100)
    |> validate_confirmation(:password, required: true, message: "password fields do not match")
    |> hash_password()
  end

  @doc """
  This changeset should be used **once** when a user account is being registered. It casts and validates all of the same fields that `basic_info_changeset` and `auth_changeset` do, in addition to casting and validating the `:age` and `:username` fields. `:username` is created at registration and should never be changed.
  """
  @username_regex ~r|^\w+$|ui
  @min_age 13
  def registration_changeset(user, params) do
    user
    |> cast(params, [:username, :age])
    |> validate_required([:username, :age])
    |> validate_length(:username, max: 20)
    |> validate_format(:username, @username_regex)
    |> unique_constraint(:username, name: :users_pkey)
    |> validate_number(:age,
      greater_than_or_equal_to: @min_age,
      message: "must be %{number} or older to register"
    )
    |> basic_info_changeset(params)
    |> auth_changeset(params)
  end

  @doc """
  This changeset should be used whenever a user needs to update their 2FA settings. It only requires that the `:has_2fa` field be set to `true` or `false`.
  """
  def two_factor_auth_changeset(user, params) do
    user
    |> cast(params, [:has_2fa])
    |> validate_required([:has_2fa])
  end

  @doc """
  This changeset should be used whenever a used wants to attach an RSN to their account. RSN validation with the OSRS API is outside the scope of the changeset so should be done ideally before applying this changeset to the database.
  """
  @rsn_regex ~r|^\w[\w- ]*\w$|ui
  def rsn_changeset(user, params) do
    user
    |> cast(params, [:rsn])
    |> validate_required([:rsn])
    |> validate_length(:rsn, min: 2, max: 12)
    |> validate_format(:rsn, @rsn_regex)
    |> unique_constraint(:rsn)
  end

  @doc """
  This changeset should be used whenever an admin needs to update the role of some user. It only requires that the `:role` field be set to one of `:user`, `:premium_user`, `:mod` or `:admin`.
  """
  @roles ~w[user premium_user mod admin]
  def role_changeset(user, params) do
    user
    |> cast(params, [:role])
    |> validate_required([:role])
    |> validate_inclusion(:role, @roles)
  end

  #### CHANGESET PLUGINS ####

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
