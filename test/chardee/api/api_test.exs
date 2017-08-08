defmodule Chardee.APITest do
  use Chardee.DataCase

  alias Chardee.API

  describe "apps" do
    alias Chardee.API.App

    @valid_attrs %{api_key: "some api_key",  name: "some app"}
    @update_attrs %{api_key: "some updated api_key", name: "some updated app"}
    @invalid_attrs %{api_key: nil, name: nil}

    def app_fixture(attrs \\ %{}) do
      {:ok, app} =
        attrs
        |> Enum.into(@valid_attrs)
        |> API.create_app()

      app
    end

    test "list_apps/0 returns all apps" do
      app = app_fixture()
      assert API.list_apps() == [app]
    end

    test "get_app!/1 returns the app with given id" do
      app = app_fixture()
      assert API.get_app!(app.id) == app
    end

    test "create_app/1 with valid data creates a app" do
      assert {:ok, %App{} = app} = API.create_app(@valid_attrs)
      assert app.api_key == "some api_key"
      assert app.name == "some app"
    end

    test "create_app/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = API.create_app(@invalid_attrs)
    end

    test "update_app/2 with valid data updates the app" do
      app = app_fixture()
      assert {:ok, app} = API.update_app(app, @update_attrs)
      assert %App{} = app
      assert app.api_key == "some updated api_key"
      assert app.name == "some updated app"
    end

    test "update_app/2 with invalid data returns error changeset" do
      app = app_fixture()
      assert {:error, %Ecto.Changeset{}} = API.update_app(app, @invalid_attrs)
      assert app == API.get_app!(app.id)
    end

    test "delete_app/1 deletes the app" do
      app = app_fixture()
      assert {:ok, %App{}} = API.delete_app(app)
      assert_raise Ecto.NoResultsError, fn -> API.get_app!(app.id) end
    end

    test "change_app/1 returns a app changeset" do
      app = app_fixture()
      assert %Ecto.Changeset{} = API.change_app(app)
    end
  end
end
