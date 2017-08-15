defmodule ChardeeWeb.API.TestView do
  use ChardeeWeb, :view

  def render("index.json", %{}) do
    %{test: "success"}
  end
end
