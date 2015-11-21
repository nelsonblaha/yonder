defmodule Yonder.Repo.Migrations.CreateAttraction do
  use Ecto.Migration

  def change do
    create table(:attractions) do
      add :name, :string
      add :lat, :float
      add :long, :float

      timestamps
    end

  end
end
