defmodule VarrockSquare.Accounts.Guardian do
  use Guardian, otp_app: :varrock_square

  alias VarrockSquare.Accounts

  def subject_for_token(user, _claims) do
    {:ok, user.username}
  end

  def resource_from_claims(%{"sub" => username}) do
    case Accounts.get_user(username) do
      nil ->
        {:error, :user_not_found}

      user ->
        {:ok, user}
    end
  end
end
