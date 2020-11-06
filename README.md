# Varrock Square

Varrock Square is a social blogging platform designed for the free-to-play [Old School RuneScape](https://oldschool.runescape.com) community. It's the perfect tool if you want to write a guide for your fellow players, or simply keep a log of your daily progress. Perhaps you want to discuss potential updates to the game, attaching a poll for quick feedback? On Varrock Square, you can do all this and more!

The app could easily be repurposed for other community interests.

## Status

_Pre-alpha (under development)_

# Repo

## Documents

- [API Documentation](API.md)

## Run a Dev Server

1. Make sure you have the latest _elixir_ as well as _Pheonix 1.5.6_ installed. We will also need _npm_ to manage our static assets.
1. Clone the repo and `cd` into it.
1. Edit (at minimum) your [`config/dev.exs`](config/dev.exs) configuration file with the _Postgres_ username & password for your own development database.
1. Install dependencies and setup the database:

   1. ```bash
      mix setup
      ```

1. Generate a certificate since we're configured to use HTTPS on port `4001` in dev mode:

   1. ```bash
      mix ecto.gen.cert
      ```

      - This will setup a private key and and a self-signed certificate at `priv/cert/` where [`config/dev.exs`](config/dev.exs) expects to find them.

1. Finally, run the dev server:

   1. ```bash
      mix phx.server
      ```

### Notes

- This project uses _Webpack 4_ for static assets. `priv/static/` is generated and serves as Phoenix's public assets directory. It never needs to be cleaned by hand since this project's config uses `CleanWebpackPlugin` to clean the folder on each build.
- [ ] **`TODO`** There are some kinks to work out regarding the omission of the `CopyWebpackPlugin` step(s) on _most_ subsequent incremental builds. This means that you may have to rebuild static assets entirely each time this happens. Luckily, due to Pheonix's awesome HMR, you may not even need to restart the server.
  - Assuming a dev build, you could run this command from the root project directory in another shell instance while the server is still running:
  ```bash
  (cd assets && npm run build)
  ```

## Contributions

While contributions are usually appreciated and welcome, I won't be accepting pull requests for this repo. This will change to allow contributions after a `v1.0.0` release.

## License

This project is licensed under the `GNU GPL v3`. See [`LICENSE`](LICENSE) for details.
