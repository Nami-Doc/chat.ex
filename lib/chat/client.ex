defmodule Chat.Client do
	def loop(name) do
		receive do
			{:message, _from_user, message} ->
				IO.puts("[#{name}] I received #{message}")
				loop(name)
		end
	end

	def start_link(name) do
		Task.start_link(fn -> loop(name) end)
	end
end