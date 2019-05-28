defmodule Mobilizon.Service.Export.Feed do
  @moduledoc """
  Serve Atom Syndication Feeds
  """

  alias Mobilizon.Users.User
  alias Mobilizon.Users
  alias Mobilizon.Actors
  alias Mobilizon.Actors.Actor
  alias Mobilizon.Events
  alias Mobilizon.Events.{Event, FeedToken}
  alias Atomex.{Feed, Entry}
  import MobilizonWeb.Gettext
  alias MobilizonWeb.Router.Helpers, as: Routes
  alias MobilizonWeb.Endpoint
  alias MobilizonWeb.MediaProxy
  require Logger

  @version Mix.Project.config()[:version]
  def version(), do: @version

  @spec create_cache(String.t()) :: {:commit, String.t()} | {:ignore, any()}
  def create_cache("actor_" <> name) do
    with {:ok, res} <- fetch_actor_event_feed(name) do
      {:commit, res}
    else
      err ->
        {:ignore, err}
    end
  end

  @spec create_cache(String.t()) :: {:commit, String.t()} | {:ignore, any()}
  def create_cache("token_" <> token) do
    with {:ok, res} <- fetch_events_from_token(token) do
      {:commit, res}
    else
      err ->
        {:ignore, err}
    end
  end

  @spec fetch_actor_event_feed(String.t()) :: String.t()
  defp fetch_actor_event_feed(name) do
    with %Actor{} = actor <- Actors.get_local_actor_by_name(name),
         {:visibility, true} <- {:visibility, Actor.public_visibility?(actor)},
         {:ok, events, _count} <- Events.get_public_events_for_actor(actor) do
      {:ok, build_actor_feed(actor, events)}
    else
      err ->
        {:error, err}
    end
  end

  # Build an atom feed from actor and it's public events
  @spec build_actor_feed(Actor.t(), list(), boolean()) :: String.t()
  defp build_actor_feed(%Actor{} = actor, events, public \\ true) do
    display_name = Actor.display_name(actor)
    self_url = Routes.feed_url(Endpoint, :actor, actor.preferred_username, "atom") |> URI.decode()

    title =
      if public,
        do: "%{actor}'s public events feed on Mobilizon",
        else: "%{actor}'s private events feed on Mobilizon"

    # Title uses default instance language
    feed =
      Feed.new(
        self_url,
        DateTime.utc_now(),
        Gettext.gettext(MobilizonWeb.Gettext, title, actor: display_name)
      )
      |> Feed.author(display_name, uri: actor.url)
      |> Feed.link(self_url, rel: "self")
      |> Feed.link(actor.url, rel: "alternate")
      |> Feed.generator("Mobilizon", uri: "https://joinmobilizon.org", version: version())
      |> Feed.entries(Enum.map(events, &get_entry/1))

    feed =
      if actor.avatar do
        feed |> Feed.icon(actor.avatar.url |> MediaProxy.url())
      else
        feed
      end

    feed =
      if actor.banner do
        feed |> Feed.logo(actor.banner.url |> MediaProxy.url())
      else
        feed
      end

    feed
    |> Feed.build()
    |> Atomex.generate_document()
  end

  # Create an entry for the Atom feed
  @spec get_entry(Event.t()) :: any()
  defp get_entry(%Event{} = event) do
    description = event.description || ""

    with {:ok, html, []} <- Earmark.as_html(description) do
      entry =
        Entry.new(event.url, event.publish_at || event.inserted_at, event.title)
        |> Entry.link(event.url, rel: "alternate", type: "text/html")
        |> Entry.content({:cdata, html}, type: "html")
        |> Entry.published(event.publish_at || event.inserted_at)

      # Add tags
      entry =
        event.tags
        |> Enum.uniq()
        |> Enum.reduce(entry, fn tag, acc -> Entry.category(acc, tag.slug, label: tag.title) end)

      Entry.build(entry)
    else
      {:error, _html, error_messages} ->
        Logger.error("Unable to produce HTML for Markdown", details: inspect(error_messages))
    end
  end

  @spec fetch_events_from_token(String.t()) :: String.t()
  defp fetch_events_from_token(token) do
    with {:ok, _uuid} <- Ecto.UUID.cast(token),
         %FeedToken{actor: actor, user: %User{} = user} <- Events.get_feed_token(token) do
      case actor do
        %Actor{} = actor ->
          events = fetch_identity_going_to_events(actor)
          {:ok, build_actor_feed(actor, events, false)}

        nil ->
          with actors <- Users.get_actors_for_user(user),
               events <-
                 actors
                 |> Enum.map(&Events.list_event_participations_for_actor/1)
                 |> Enum.concat() do
            {:ok, build_user_feed(events, user, token)}
          end
      end
    end
  end

  defp fetch_identity_going_to_events(%Actor{} = actor) do
    with events <- Events.list_event_participations_for_actor(actor) do
      events
    end
  end

  # Build an atom feed from actor and it's public events
  @spec build_user_feed(list(), User.t(), String.t()) :: String.t()
  defp build_user_feed(events, %User{email: email}, token) do
    self_url = Routes.feed_url(Endpoint, :going, token, "atom") |> URI.decode()

    # Title uses default instance language
    Feed.new(
      self_url,
      DateTime.utc_now(),
      gettext("Feed for %{email} on Mobilizon", email: email)
    )
    |> Feed.link(self_url, rel: "self")
    |> Feed.generator("Mobilizon", uri: "https://joinmobilizon.org", version: version())
    |> Feed.entries(Enum.map(events, &get_entry/1))
    |> Feed.build()
    |> Atomex.generate_document()
  end
end