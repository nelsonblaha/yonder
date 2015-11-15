defmodule Yonder.PageController do
  use Yonder.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
