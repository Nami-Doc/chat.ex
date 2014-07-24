defmodule Chat.Handler do
  def handle(responder, _msg) do
  	# todo dispatch this :(
  	send responder, {:ok, "message sent !"}
  end
end