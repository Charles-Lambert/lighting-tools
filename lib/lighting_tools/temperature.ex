defmodule Lighting_Tools.Temperature do

#  def interpolatebad(points, x) do
#    [head| tail] = Enum.sort(points)
#    Enum.reduce_while(tail, head, fn(point, last_point) ->
#      cond do
#        elem(point, 0) < x ->
#          {:cont, point}
#        true -> 
#          {x1, y1} = point
#          {x2, y2} = last_point
#          {:halt, y1+(x-x1)*(y1-y2)/(x1-x2)}
#      end
#    end)
#  end

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


  def placeholder_temp(time) do
    t=time.hour+time.minute/60
    cond do 
      8 < t and t < 21 ->
        2000*(8-t)/13+4500

      true ->
        2500
    end
  end
  
  def temperature_wrapper() do
    temp=Time.utc_now|>placeholder_temp
    %Lifx.Protocol.HSBK{hue: -1, saturation: -1, brightness: -1, kelvin: temp}
  end

  def temperature(points \\ [{6,2500},{6.1,4500},{21,2500}]) do
    temp=(Time.utc_now.hour+ Time.utc_now.minute / 60+ Time.utc_now.second / 3600) |> interpolate(points) |> round
    %Lifx.Protocol.HSBK{hue: -1, saturation: -1, brightness: -1, kelvin: temp}
  end


end

