defmodule Lighting_Tools do
  @moduledoc """
  Documentation for Lighting_tools.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Smartbulb2.hello()
      :world

  """

  def loop(bulb,n) do
    if n > 0 do
      {:ok, color} = Lifx.Device.get_color(bulb)
      temp =Time.utc_now |> Lighting_Tools.Temperature.placeholder_temp |> round
      Lifx.Device.set_color(bulb, %{color | kelvin: temp}, 10000)
      IO.puts(n)
      :timer.sleep(1000*60*5)
      loop(bulb, n-1)
    else :ok
    end
  end
end
