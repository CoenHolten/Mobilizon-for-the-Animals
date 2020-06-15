defmodule Mix.Tasks.Mobilizon.Actors.Refresh do
  @moduledoc """
  Task to display an actor details
  """
  use Mix.Task
  alias Mobilizon.Actors.Actor
  alias Mobilizon.Federation.ActivityPub
  alias Mobilizon.Storage.Repo
  import Ecto.Query
  require Logger

  @shortdoc "Refresh an actor or all actors"

  @impl Mix.Task
  def run(["--all" | options]) do
    {options, [], []} =
      OptionParser.parse(
        options,
        strict: [
          verbose: :boolean
        ],
        aliases: [
          v: :verbose
        ]
      )

    verbose = Keyword.get(options, :verbose, false)

    Mix.Task.run("app.start")

    total = count_actors()

    Mix.shell().info("""
    #{total} actors to process
    """)

    query = from(a in Actor, where: not is_nil(a.domain) and not a.suspended)

    {:ok, _res} =
      Repo.transaction(
        fn ->
          query
          |> Repo.stream(timeout: :infinity)
          |> Stream.map(&"#{&1.preferred_username}@#{&1.domain}")
          |> Stream.each(
            if verbose,
              do: &Logger.info("Processing #{inspect(&1)}"),
              else: &Logger.debug("Processing #{inspect(&1)}")
          )
          |> Stream.map(fn username -> make_actor(username, verbose) end)
          |> Stream.scan(0, fn _, acc -> acc + 1 end)
          |> Stream.each(fn index ->
            if verbose,
              do: Logger.info("#{index}/#{total}"),
              else: ProgressBar.render(index, total)
          end)
          |> Stream.run()
        end,
        timeout: :infinity
      )
  end

  @impl Mix.Task
  def run([preferred_username]) do
    Mix.Task.run("app.start")

    case ActivityPub.make_actor_from_nickname(preferred_username) do
      {:ok, %Actor{}} ->
        Mix.shell().info("""
        Actor #{preferred_username} refreshed
        """)

      {:actor, nil} ->
        Mix.raise("Error: No such actor")
    end
  end

  @impl Mix.Task
  def run(_) do
    Mix.raise("mobilizon.actors.refresh requires an username as argument or --all as an option")
  end

  @spec make_actor(String.t(), boolean()) :: any()
  defp make_actor(username, verbose) do
    ActivityPub.make_actor_from_nickname(username)
  rescue
    _ ->
      if verbose do
        Logger.warn("Failed to refresh #{username}")
      end

      nil
  end

  defp count_actors do
    Repo.aggregate(from(a in Actor, where: not is_nil(a.domain)), :count)
  end
end