# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :chardee,
  ecto_repos: [Chardee.Repo]

# Configures the endpoint
config :chardee, ChardeeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8BWZi0PR/q7FTVKeuaFuoAAu8UmC2dMyhzm7i63SsGQErz8KloOcxzOgveq/fHYf",
  render_errors: [view: ChardeeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Chardee.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "chardee",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: "A4jNakkhzikLif/9/xNjgjcRQcB0hDEGfyJP2IKog0uEzemItJdSkaM8tcOscS1t",
  serializer: ChardeeWeb.TokenSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
