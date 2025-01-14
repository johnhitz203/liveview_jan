defmodule AmnesiaWeb.GameLive do
  alias Amnesia.Eraser
  use AmnesiaWeb, :live_view

  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(eraser: eraser())}
  end

  defp eraser() do
    %{title: "IT Crowd", text: "Did you try turning it on and off again?", steps: 3}
    |> Eraser.new()
  end

  def render(assigns) do
    ~H"""

      <h1> <%= Eraser.show(@eraser) %> </h1>

      <button
        phx-click="erase"
        class="bg-red-600 hover:bg-red-500 text-white font-bold mt-4 py-2 px-4 rounded"
        >
        Erase
      </button>

    """
  end

  def handle_event("erase", %{"value" => ""}, socket) do
    {:noreply, erase(socket)}
  end

  defp erase(socket) do
    socket
    |> assign(eraser: Eraser.erase(socket.assigns.eraser))
  end
end
