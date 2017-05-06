defmodule Issues.Mixfile do
  use Mix.Project

  def project do
    [
      app: :issues,
      build_embedded: Mix.env == :prod,
      deps: deps(),
      elixir: "~> 1.4",
      escript: escript_config(),
      name: "Issues",
      source_url: "https://github.com/thewoolleyman/programming-elixir/tree/master/exercises/chapter-13/01-OrganizingAProject-1/issues",
      start_permanent: Mix.env == :prod,
      version: "0.1.0",
     ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:earmark, "~> 1.0", override: true},
      {:ex_doc, "~> 0.12"},
      {:httpoison, "~>0.11"},
      {:poison, "~>3.1"}
    ]
  end

  defp escript_config do
    [main_module: Issues.CLI]
  end
end
