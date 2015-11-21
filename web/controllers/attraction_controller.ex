defmodule Yonder.AttractionController do
  use Yonder.Web, :controller

  alias Yonder.Attraction

  plug :scrub_params, "attraction" when action in [:create, :update]

  def index(conn, _params) do
    attractions = Repo.all(Attraction)
    render(conn, "index.html", attractions: attractions)
  end

  def map(conn, _params) do
    attractions = Repo.all(Attraction)
    render(conn, "mapindex.html", attractions: attractions)
  end

  def new(conn, _params) do
    changeset = Attraction.changeset(%Attraction{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"attraction" => attraction_params}) do
    changeset = Attraction.changeset(%Attraction{}, attraction_params)

    case Repo.insert(changeset) do
      {:ok, _attraction} ->
        conn
        |> put_flash(:info, "Attraction created successfully.")
        |> redirect(to: attraction_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    attraction = Repo.get!(Attraction, id)
    render(conn, "show.html", attraction: attraction)
  end

  def edit(conn, %{"id" => id}) do
    attraction = Repo.get!(Attraction, id)
    changeset = Attraction.changeset(attraction)
    render(conn, "edit.html", attraction: attraction, changeset: changeset)
  end

  def update(conn, %{"id" => id, "attraction" => attraction_params}) do
    attraction = Repo.get!(Attraction, id)
    changeset = Attraction.changeset(attraction, attraction_params)

    case Repo.update(changeset) do
      {:ok, attraction} ->
        conn
        |> put_flash(:info, "Attraction updated successfully.")
        |> redirect(to: attraction_path(conn, :show, attraction))
      {:error, changeset} ->
        render(conn, "edit.html", attraction: attraction, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    attraction = Repo.get!(Attraction, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(attraction)

    conn
    |> put_flash(:info, "Attraction deleted successfully.")
    |> redirect(to: attraction_path(conn, :index))
  end
end
