defmodule Lighting_Tools.Utils do
  alias Lifx.Device
  alias Lifx.Protocol.HSBK
  require Logger

  def set_color(%Device{} = device, %HSBK{} = hsbk, duration \\ 1000) do
    new_color = hsbk
    Logger.info(new_color |> inspect)
    new_color = if hsbk.hue == -1 or hsbk.saturation == -1 or hsbk.brightness == -1 or hsbk.kelvin == -1 do
      {:ok, old_color} = Device.get_color(device)
      hue = if hsbk.hue == -1, do: old_color.hue, else: hsbk.hue
      saturation = if hsbk.saturation == -1, do: old_color.saturation, else: hsbk.saturation
      brightness = if hsbk.brightness == -1, do: old_color.brightness, else: hsbk.brightness
      kelvin = if hsbk.kelvin == -1, do: old_color.kelvin, else: hsbk.kelvin
      %Lifx.Protocol.HSBK{hue: hue, saturation: saturation, brightness: brightness, kelvin: kelvin}
    else 
      hsbk
    end
    Logger.info(new_color |> inspect)
    Lifx.Device.set_color(device, new_color, duration)
  end

  def repeat(device, delay, fade, fun, args) do
    color=apply(fun, args)
    Lighting_Tools.Utils.set_color(device, color, fade)
    :timer.sleep(delay)
    repeat(device, delay, fade, fun, args)
  end

  def repeat(device, delay, fade, module, fun, args) do
    color=apply(module, fun, args)
    Lighting_Tools.Utils.set_color(device, color, fade)
    :timer.sleep(delay)
    repeat(device, delay, fade, module, fun, args)
  end

    def interpolate(x,points) do
    {xs,ys}=points |> Enum.sort |> Enum.unzip
    do_interpolate(xs,ys,x)
  end

  def do_interpolate([hx|tx],[hy|ty], x) do
    cond do
      length(tx)==0 ->
        hy
      hx > x ->
        hy
      tx |> hd > x ->
        x2 = tx |> hd
        y2 = ty |> hd
        hy+(x-hx)*(hy-y2)/(hx-x2)
      true ->
        do_interpolate(tx,ty,x)
      end
  end
end

