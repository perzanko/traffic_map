defmodule TrafficMap.MixProject do
  use Mix.Project

  def project do
    [
      app: :traffic_map,
      version: "0.1.0",
      elixir: "~> 1.9",
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {TrafficMap.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.4.9"},
      {:gettext, "~> 0.11"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_pubsub, "~> 1.1"}
    ]
  end

  defp aliases do
    [
      "build:js": ["parcel build assets/js/src/index.js --out-dir priv/static/js"]
    ]
  end
end
