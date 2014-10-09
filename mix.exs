defmodule Frontend.Mixfile do
  use Mix.Project

  def project do
    [ app: :frontend,
      version: "0.1.0",
      elixir: "~> 1.0.0",
      elixirc_paths: ["lib", "web"],
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Frontend, [] },
      applications: [:postgrex, :ecto, :phoenix]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:phoenix,          "~> 0.4.1"},
      {:plug,             "~> 0.7.0", override: true},
      {:plug_byte_serve,  "~> 0.3.0"},
      {:cowboy,           "~> 1.0.0"},
      {:postgrex,         ">= 0.0.0"},
      {:ecto,             "~> 0.2.0"}
    ]
  end
end
