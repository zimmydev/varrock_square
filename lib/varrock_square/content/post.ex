defmodule VarrockSquare.Content.Post do
  @moduledoc """
  This module represents a post that any user can publish.
  """
  use Ecto.Schema
  # import Ecto.Changeset
  # alias Ecto.Changeset

  alias VarrockSquare.Accounts.User

  #### SCHEMA ####

  @primary_key {:slug, :string, autogenerate: false}

  schema "posts" do
    field :is_published, :boolean, default: false
    # Posts have a title with a 255-character limit
    field :title, :string
    # Posts have a body which can
    field :body, :string, default: ""
    belongs_to :user, User, foreign_key: :author, references: :username, type: :string
  end
end
