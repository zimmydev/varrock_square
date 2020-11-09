alias VarrockSquare.Repo
alias VarrockSquare.Accounts

users_attrs = [
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

# Register a bunch of users
Enum.each(users_attrs, &Accounts.register_user/1)
