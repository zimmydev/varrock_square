alias VarrockSquare.Repo
alias VarrockSquare.Accounts.User
alias VarrockSquare.Content.Post

post_params = [
  {"TestDummy", %{slug: "bryo-guide-f5xp81", title: "Bryo Guide", body: "# Bryo Guide\n"}},
  {"TrustNoBanks", %{slug: "welcome-varrock-square-nf02mq", title: "Welcome to Varrock Square!"}}
]

# Create a bunch of unpublished posts
post_params
|> Enum.map(fn {username, attrs} ->
  Repo.get!(User, username)
  |> Ecto.build_assoc(:posts, attrs)
  |> Repo.insert!()
end)
