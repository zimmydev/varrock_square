alias VarrockSquare.Repo
alias VarrockSquare.Accounts.User

user_params = [
  %{
    username: "TrustNoBanks",
    age: 27,
    email: "bzimmermandev@icloud.com",
    password: "password123",
    password_confirmation: "password123"
  },
  %{
    username: "TestDummy",
    age: 13,
    email: "test.dummy+varrocksquare@example.com",
    password: "password456",
    password_confirmation: "password456"
  },
  %{
    username: "TestDummyJr",
    age: 27,
    email: "jr-testdummy@gmail.com",
    password: "foobar",
    password_confirmation: "foobar"
  }
]

user_params
|> Enum.map(&User.registration_changeset(%User{}, &1))
|> Enum.map(&Repo.insert!/1)
