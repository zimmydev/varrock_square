alias VarrockSquare.Repo
alias VarrockSquare.Accounts.User
alias VarrockSquare.Content.Post

post_params = [
  {"TrustNoBanks", %{slug: "welcome-varrock-square-nf02mq", title: "Welcome to Varrock Square!"}},
  {"say_f2p_ult",
   %{
     slug: "bryo-guide-f5xp81",
     title: "Bryo Guide",
     body: "# Bryo Guide\n\n- Slap hard\n\nTo be continued…"
   }}
]

# Create a bunch of unpublished posts
for {username, attrs} <- post_params do
  Repo.get!(User, username)
  |> Ecto.build_assoc(:posts, attrs)
  |> Repo.insert!()
end
