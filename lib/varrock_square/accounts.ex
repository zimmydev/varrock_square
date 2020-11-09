defmodule VarrockSquare.Accounts do
  alias VarrockSquare.Repo
  alias VarrockSquare.Accounts.User

  def get_user(username) do
    Repo.get(User, username)
  end

  def get_user_by(clauses) do
    Repo.get_by(User, clauses)
  end

  def register_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end
end
