defmodule VarrockSquare.Content.Post do
  @moduledoc """
  This module represents a post that any user can publish.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  alias VarrockSquare.Accounts.User

  #### SCHEMA ####

  @primary_key {:slug, :string, autogenerate: false}

  schema "posts" do
    field :is_published, :boolean, default: false
    # Posts have a title with a 255-character limit
    field :title, :string
    # Posts have a body which can
    field :body, :string, default: ""
    # Posts are owned by a user
    belongs_to :user, User, foreign_key: :author, references: :username, type: :string
    # User join & last-modified date.
    timestamps()
  end

  #### CHANGESETS ####

  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :is_published])
    |> validate_required([:title, :is_published])
    |> validate_length(:title, min: 3, max: 255)
    |> validate_body_if_publishing()
    |> put_post_slug()
  end

  #### CHANGESET PLUGINS ####

  defp validate_body_if_publishing(changeset) do
    case changeset do
      %Changeset{valid?: true, changes: %{is_published: true}} ->
        changeset
        |> validate_required([:body])
        |> validate_length(:body, min: 1)

      _ ->
        changeset
    end
  end

  defp put_post_slug(changeset) do
    case changeset do
      %Changeset{valid?: true, data: %__MODULE__{title: title}} ->
        put_change(changeset, :slug, generate_slug(title))
        # NOTE It's very unlikely slugs will collide, but we should still alert Ecto this has a unique constraint
        |> unique_constraint(:slug)

      _invalid_changeset ->
        changeset
    end
  end

  #### HELPERS ####

  @prefix_max_length 20
  defp generate_slug(title) do
    title
    |> shrink_title()
    |> Slug.slugify(truncate: @prefix_max_length)
    |> apply_random_suffix()
  end

  @rejected_words ~w[a an the at by of to with for in as but so then than when if yet]
  defp shrink_title(title) do
    title
    |> String.downcase()
    |> String.split()
    |> Stream.reject(&Enum.member?(@rejected_words, &1))
    |> Enum.join(" ")
  end

  defp apply_random_suffix(nil), do: apply_random_suffix("")

  @default_post_slug "post"
  defp apply_random_suffix(""), do: @default_post_slug <> "-" <> generate_suffix()

  defp apply_random_suffix(slug), do: slug <> "-" <> generate_suffix()

  @suffix_length 6
  defp generate_suffix() do
    :crypto.strong_rand_bytes(@suffix_length)
    |> Base.url_encode64()
    |> binary_part(0, @suffix_length)
  end
end
