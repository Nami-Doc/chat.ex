defmodule Chat do
  @moduledoc """
  How do i chat pls
  """

  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Chat.Supervisor.start_link
  end

  def start_listen(port) do
    tcp_opt = [:list, {:packet, 0}, {:active false}, {:reuseaddr, true}]
    {:ok, listen_sock} = :gen_tcp.listen(port, tcp_opt)
    listen(listen_sock)
  end

  def listen(listen_sock) do
    {:ok, socket} = :gen_tcp.accept(listen_sock)
    spawn(fn -> do_server(socket) end)
    listen(listen_sock)
  end
  
  defp handle(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} ->
        responder = spawn(fn -> respond(socket) end)
        # todo store the socket to dispatch new messages (?)
        spawn(Chat.Handler, :handle, [responder, list_to_binary(data)])
        handle(socket)

      {:error, :closed} ->
        Logger.log :debug, "Got a connection close"
        :ok
    end
  end

  defp answer(socket) do
    receive do
      {:ok, response} ->
        :gen_tcp.send(socket, response <> "\n")
        Logger.log(:message, response)
    end
  end
end
