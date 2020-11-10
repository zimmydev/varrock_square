defmodule VarrockSquare.Accounts.Guardian do
  use Guardian, otp_app: :varrock_square

  alias VarrockSquare.Accounts

  def subject_for_token(user, _claims) do
    {:ok, user.username}
  end

  def resource_from_claims(%{"sub" => username}) do
    user = Accounts.get_user!(username)
    {:ok, user}
  rescue
    Ecto.NoResultsError ->
      {:error, :user_not_found}
  end
end
