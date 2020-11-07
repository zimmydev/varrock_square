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

Code.eval_file("priv/repo/seeds/users.exs")
Code.eval_file("priv/repo/seeds/posts.exs")
