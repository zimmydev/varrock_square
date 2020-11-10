# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     VarrockSquare.Repo.insert!(%VarrockSquare.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias VarrockSquare.{Accounts, Content}

users_attrs = [
  %{
    username: "TrustNoBanks",
    age: 27,
    email: "admin@varrocksquare.app",
    password: "password123",
    password_confirmation: "password123",
    rsn: "TrustNoBanks",
    bio: "Hobby web developer, owner of Varrock Square, OSRS F2P player."
  },
  %{
    username: "UncleTomas",
    age: 13,
    email: "admin@f2p.wiki",
    password: "password456",
    password_confirmation: "password456",
    rsn: "UncleTomas",
    bio: "#HeavyGang"
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
Enum.each(users_attrs, &Accounts.create_user/1)

# Make one an admin
Accounts.get_user!("TrustNoBanks")
|> Accounts.update_user_role("admin")

post_descriptors = [
  %{
    username: "TrustNoBanks",
    attrs: %{
      title: "Welcome to Varrock Square!"
    }
  },
  %{
    username: "say_f2p_ult",
    attrs: %{
      title: "Bryo Guide",
      body: "# Bryo Guide\n\n- Slap hard\n\nTo be continued…",
      is_published: true
    }
  },
  %{
    username: "TrustNoBanks",
    attrs: %{
      title: "How Much Wood Would a Woodchuck Chuck if a Woodchuck Could Chuck Wood?"
    }
  },
  %{
    username: "TrustNoBanks",
    attrs: %{
      title: "⚔️",
      body: "This has a valid title and the generated slug is probably the default",
      is_published: true
    }
  }
]

# Create a bunch of sample posts
post_descriptors
|> Enum.map(fn %{username: un, attrs: a} -> %{user: Accounts.get_user!(un), attrs: a} end)
|> Enum.each(&Content.create_post(&1.user, &1.attrs))
