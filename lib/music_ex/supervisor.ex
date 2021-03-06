defmodule MusicEx.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(MusicEx.Supervisor, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(Playlist.Store, []),
      supervisor(Playlist.Supervisor, []),
      worker(Discord.Gateway.State, []),
      worker(Player, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
