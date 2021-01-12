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

#  def interpolate([head|tail], x) do
#    cond do
#      elem(head, 0) >= x -> elem(head, 1)
  #
#      length(tail) = 1 ->
  #
#      elem(hd(tail)) > x ->
#        {x1, y1} = tail
#        {x2, y2} = head
#        {:halt, y1+(x-x1)*(y1-y2)/(x1-x2)}

  #    end
#  end


  def placeholder_temp(time) do
    t=time.hour+time.minute/60
    cond do 
      8 < t and t < 21 ->
        2000*(8-t)/13+4500

      true ->
        2500
    end
  end
end

