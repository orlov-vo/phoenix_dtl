defmodule PhoenixDtl.Mixfile do
  use Mix.Project

  def project do
    [
      app: :phoenix_dtl,
      version: "0.0.1",
      elixir: "~> 1.2",
      deps: deps(),
      package: [
        contributors: ["Andreas Gerstmayr"],
        licenses: ["MIT"],
        links: [github: "https://github.com/andihit/phoenix_dtl"]
      ],
      description: """
      Phoenix Template Engine for the django template language
      """
    ]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      {:phoenix, "~> 1.2.1"},
      {:cowboy, "~> 1.0", only: [:dev, :test]},
      {:erlydtl, github: "erlydtl/erlydtl", branch: "stable"}
    ]
  end
end
