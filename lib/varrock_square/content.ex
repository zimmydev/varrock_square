defmodule VarrockSquare.Content do
  alias VarrockSquare.{Repo, Accounts}
  alias VarrockSquare.Content.Post

  def create_post(user = %Accounts.User{}, attrs) do
    user
    |> Ecto.build_assoc(:posts, attrs)
    # Make sure we're still doing a changeset & validation:
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def publish_post(post = %Post{}) do
    post
    |> Post.changeset(%{is_published: true})
    |> Repo.update()
  end

  def unpublish_post(post = %Post{}) do
    post
    |> Post.changeset(%{is_published: false})
    |> Repo.update()
  end

  # def create_and_publish_post(user = %Accounts.User{}, attrs) do
  #   # TODO Create + publish post convenience function
  #   {:error, :todo_implementation}
  # end

  def get_post(slug), do: Repo.get(Post, slug)

  def get_post!(slug), do: Repo.get!(Post, slug)

  def update_post(post = %Post{}, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(post = %Post{}) do
    post
    |> Repo.delete()
  end
end
