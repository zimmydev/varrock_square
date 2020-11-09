alias VarrockSquare.Repo
alias VarrockSquare.Content

posts_attrs = [
  %{
    username: "TrustNoBanks",
    attrs: %{
      slug: "welcome-varrock-square-nf02mq",
      title: "Welcome to Varrock Square!"
    }
  },
  %{
    username: "say_f2p_ult",
    attrs: %{
      slug: "bryo-guide-f5xp81",
      title: "Bryo Guide",
      body: "# Bryo Guide\n\n- Slap hard\n\nTo be continued…"
    }
  }
]

# Create a bunch of unpublished posts
Enum.each(posts_attrs, &Content.create_post(&1.username, &1.attrs))
