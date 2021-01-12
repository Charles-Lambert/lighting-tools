# Lighting Tools

Tools for controlling smart lighting using elixir  
So far, only Lifx devices and simple automated control of light temperature are supported

## Temperature Control 

Tool to automatically vary the colour temperature of a smart bulb throughout the day. 
Run using 
```
Lighting_Tools.loop(device, -1)
```
Where device corresponds to the desired smart bulb.

The light temperature decreases from 4500K (neutral/cool white) at 08:00 to 2500K (very warm white/candlelight) at 21:00.
Hue, Brightness and Saturation are not affected.
Currently assumes the user is in the UTC±00:00 timezone.
