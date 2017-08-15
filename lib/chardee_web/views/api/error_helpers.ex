defmodule ChardeeWeb.API.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  def error_json(msg) do
    %{error: %{message: msg}}
  end
end
