defmodule Chat.Mixfile do
  use Mix.Project

  def project do
    [ app: :chat,
      version: "0.0.1",
      elixir: "~> 1.4.2",
      deps: deps() ]
  end

  def application do
    #[mod: { Chat.Supervisor, [] }]
    []
  end

  defp deps do
    []
  end
end
