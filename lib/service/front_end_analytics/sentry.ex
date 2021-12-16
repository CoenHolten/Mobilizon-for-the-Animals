defmodule Mobilizon.Service.FrontEndAnalytics.Sentry do
  @moduledoc """
  Sentry analytics provider
  """

  alias Mobilizon.Service.FrontEndAnalytics
  @behaviour FrontEndAnalytics

  @impl FrontEndAnalytics
  def id, do: "sentry"

  @doc """
  Whether the service is enabled
  """
  @impl FrontEndAnalytics
  def enabled? do
    :mobilizon
    |> Application.get_env(__MODULE__, [])
    |> Keyword.get(:enabled, false)
  end

  @doc """
  The configuration for the service
  """
  @impl FrontEndAnalytics
  def configuration do
    :mobilizon
    |> Application.get_env(__MODULE__, [])
    |> Keyword.drop([:enabled])
  end
end
