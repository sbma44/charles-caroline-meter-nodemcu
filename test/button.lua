function button_pressed(level, when)
    print("button pressed!")
end

gpio.mode(7, gpio.INT, gpio.PULLUP)
gpio.trig(7, "down", button_pressed)