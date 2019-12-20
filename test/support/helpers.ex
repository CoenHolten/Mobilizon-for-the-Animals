# Portions of this file are derived from Pleroma:
# Copyright © 2017-2019 Pleroma Authors <https://pleroma.social>
# SPDX-License-Identifier: AGPL-3.0-only
# Upstream: https://git.pleroma.social/pleroma/pleroma/blob/develop/test/support/helpers.ex

defmodule Mobilizon.Tests.Helpers do
  @moduledoc """
  Helpers for use in tests.
  """

  defmacro clear_config(config_path) do
    quote do
      clear_config(unquote(config_path)) do
      end
    end
  end

  defmacro clear_config(config_path, do: yield) do
    quote do
      setup do
        initial_setting = Mobilizon.Config.get(unquote(config_path))
        unquote(yield)
        on_exit(fn -> Mobilizon.Config.put(unquote(config_path), initial_setting) end)
        :ok
      end
    end
  end

  defmacro __using__(_opts) do
    quote do
      import Mobilizon.Tests.Helpers,
        only: [
          clear_config: 1,
          clear_config: 2
        ]
    end
  end
end
