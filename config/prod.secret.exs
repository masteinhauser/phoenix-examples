use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :frontend, Frontend.Endpoint,
  secret_key_base: "G3LCZEE8skfErkQFwV/3QEecjrdi8U6em7vPmMWXt+a/WG1KAoS6DX5m9089G7Vx"

# Configure your database
config :frontend, Frontend.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "frontend_prod"
