defmodule Chat.Logger do
  def log(level, message) do
    {{year, month, day}, {hour, min, sec}} = :erlang.localtime
    IO.puts "#{year}/#{month}/#{day} #{hour}:#{min}:#{sec} " <>
    	"#{String.capitalize(level)} #{message}"
  end
end