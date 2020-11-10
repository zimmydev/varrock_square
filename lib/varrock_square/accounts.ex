defmodule VarrockSquare.Accounts do
  alias VarrockSquare.{Repo, Accounts.User}

  def create_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def get_user(username), do: Repo.get(User, username)

  def get_user!(username), do: Repo.get!(User, username)

  def get_user_by(clauses), do: Repo.get_by(User, clauses)

  def get_user_by!(clauses), do: Repo.get_by!(User, clauses)

  def update_basic_user_info(user = %User{}, attrs) do
    user
    |> User.basic_info_changeset(attrs)
    |> Repo.update()
  end

  def update_user_auth(user = %User{}, attrs) do
    user
    |> User.auth_changeset(attrs)
    |> Repo.update()
  end

  def update_user_two_factor_auth(user = %User{}, enabled?) do
    user
    |> User.two_factor_auth_changeset(%{has_2fa: enabled?})
    |> Repo.update()
  end

  def update_user_role(user = %User{}, role) do
    user
    |> User.role_changeset(%{role: role})
    |> Repo.update()
  end

  def delete_user(user = %User{}, username_confirmation) do
    cond do
      user.username == username_confirmation ->
        user
        |> Repo.delete()

      true ->
        {:error, :incorrect_confirmation}
    end
  end
end
