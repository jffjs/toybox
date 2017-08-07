defmodule Chardee.APITest do
  use Chardee.DataCase

  alias Chardee.API

  describe "api_credentials" do
    alias Chardee.API.APICredential

    @valid_attrs %{api_key: "some api_key", api_secret: "some api_secret", app: "some app"}
    @update_attrs %{api_key: "some updated api_key", api_secret: "some updated api_secret", app: "some updated app"}
    @invalid_attrs %{api_key: nil, api_secret: nil, app: nil}

    def api_credential_fixture(attrs \\ %{}) do
      {:ok, api_credential} =
        attrs
        |> Enum.into(@valid_attrs)
        |> API.create_api_credential()

      api_credential
    end

    test "list_api_credentials/0 returns all api_credentials" do
      api_credential = api_credential_fixture()
      assert API.list_api_credentials() == [api_credential]
    end

    test "get_api_credential!/1 returns the api_credential with given id" do
      api_credential = api_credential_fixture()
      assert API.get_api_credential!(api_credential.id) == api_credential
    end

    test "create_api_credential/1 with valid data creates a api_credential" do
      assert {:ok, %APICredential{} = api_credential} = API.create_api_credential(@valid_attrs)
      assert api_credential.api_key == "some api_key"
      assert api_credential.api_secret == "some api_secret"
      assert api_credential.app == "some app"
    end

    test "create_api_credential/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = API.create_api_credential(@invalid_attrs)
    end

    test "update_api_credential/2 with valid data updates the api_credential" do
      api_credential = api_credential_fixture()
      assert {:ok, api_credential} = API.update_api_credential(api_credential, @update_attrs)
      assert %APICredential{} = api_credential
      assert api_credential.api_key == "some updated api_key"
      assert api_credential.api_secret == "some updated api_secret"
      assert api_credential.app == "some updated app"
    end

    test "update_api_credential/2 with invalid data returns error changeset" do
      api_credential = api_credential_fixture()
      assert {:error, %Ecto.Changeset{}} = API.update_api_credential(api_credential, @invalid_attrs)
      assert api_credential == API.get_api_credential!(api_credential.id)
    end

    test "delete_api_credential/1 deletes the api_credential" do
      api_credential = api_credential_fixture()
      assert {:ok, %APICredential{}} = API.delete_api_credential(api_credential)
      assert_raise Ecto.NoResultsError, fn -> API.get_api_credential!(api_credential.id) end
    end

    test "change_api_credential/1 returns a api_credential changeset" do
      api_credential = api_credential_fixture()
      assert %Ecto.Changeset{} = API.change_api_credential(api_credential)
    end
  end
end
