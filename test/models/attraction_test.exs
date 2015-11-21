defmodule Yonder.AttractionTest do
  use Yonder.ModelCase

  alias Yonder.Attraction

  @valid_attrs %{lat: "120.5", long: "120.5", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Attraction.changeset(%Attraction{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Attraction.changeset(%Attraction{}, @invalid_attrs)
    refute changeset.valid?
  end
end
