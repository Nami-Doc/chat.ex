defmodule Chat do
  @moduledoc """
  How do i chat pls
  """

  use GenServer

  def start_link(state, opts \\ []) do
    GenServer.start_link(__MODULE__, state, opts)
  end

  def broadcast(user, message) do
    GenServer.cast(__MODULE__, {:broadcast, user, message})
  end

  def subscribe_user(user) do
    GenServer.cast(__MODULE__, {:subscribe_user, user})
  end

  def list_users do
    GenServer.call(__MODULE__, :list_users)
  end

  def handle_cast({:broadcast, from_user, message}, users) do
    # TODO check if user in users
    # Enum.member?(users, user)

    Enum.each(users, fn(user) -> send(user, {:message, from_user, message}) end)
    {:noreply, users}
  end

  def handle_cast({:subscribe_user, user}, users) do
    {:noreply, [user|users]} # just prepend
  end

  def handle_call(:list_users, _from, users) do
    {:reply, users, users}
  end

end
