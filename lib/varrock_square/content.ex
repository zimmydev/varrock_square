defmodule VarrockSquare.Content do
  alias VarrockSquare.Repo
  alias VarrockSquare.Accounts

  def create_post(username, attrs) do
    case Accounts.get_user(username) do
      user = %Accounts.User{} ->
        user
        |> Ecto.build_assoc(:posts, attrs)
        |> Repo.insert!()

        :ok

      nil ->
        {:error, :user_does_not_exist}
    end
  end
end
