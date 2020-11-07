alias VarrockSquare.Repo
alias VarrockSquare.Accounts.User

user_registration_params = [
  %{
    username: "TrustNoBanks",
    age: 27,
    email: "admin@varrocksquare.net",
    password: "password123",
    password_confirmation: "password123"
  },
  %{
    username: "UncleTomas",
    age: 13,
    email: "admin@f2p.wiki",
    password: "password456",
    password_confirmation: "password456"
  },
  %{
    username: "say_f2p_ult",
    age: 90,
    email: "theotheradmin@f2p.wiki",
    password: "foobar",
    password_confirmation: "foobar"
  }
]

user_registration_params
|> Enum.map(&User.registration_changeset(%User{}, &1))
|> Enum.map(&Repo.insert!/1)
