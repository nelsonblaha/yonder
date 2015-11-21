defmodule Yonder.AttractionControllerTest do
  use Yonder.ConnCase

  alias Yonder.Attraction
  @valid_attrs %{lat: "120.5", long: "120.5", name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, attraction_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing attractions"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, attraction_path(conn, :new)
    assert html_response(conn, 200) =~ "New attraction"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, attraction_path(conn, :create), attraction: @valid_attrs
    assert redirected_to(conn) == attraction_path(conn, :index)
    assert Repo.get_by(Attraction, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, attraction_path(conn, :create), attraction: @invalid_attrs
    assert html_response(conn, 200) =~ "New attraction"
  end

  test "shows chosen resource", %{conn: conn} do
    attraction = Repo.insert! %Attraction{}
    conn = get conn, attraction_path(conn, :show, attraction)
    assert html_response(conn, 200) =~ "Show attraction"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, attraction_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    attraction = Repo.insert! %Attraction{}
    conn = get conn, attraction_path(conn, :edit, attraction)
    assert html_response(conn, 200) =~ "Edit attraction"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    attraction = Repo.insert! %Attraction{}
    conn = put conn, attraction_path(conn, :update, attraction), attraction: @valid_attrs
    assert redirected_to(conn) == attraction_path(conn, :show, attraction)
    assert Repo.get_by(Attraction, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    attraction = Repo.insert! %Attraction{}
    conn = put conn, attraction_path(conn, :update, attraction), attraction: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit attraction"
  end

  test "deletes chosen resource", %{conn: conn} do
    attraction = Repo.insert! %Attraction{}
    conn = delete conn, attraction_path(conn, :delete, attraction)
    assert redirected_to(conn) == attraction_path(conn, :index)
    refute Repo.get(Attraction, attraction.id)
  end
end
