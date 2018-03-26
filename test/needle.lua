function set_meter(b)
    if b == 0 then
        cycle_meter()
    else
        gpio.serout(5, gpio.HIGH, { 1000 }, b, cycle_meter)
    end
end

function cycle_meter()
    gpio.write(5, gpio.LOW);
    gpio.serout(6, gpio.HIGH, { 1000 }, 1, function() gpio.write(6, gpio.LOW); print("cycled meter"); end)
end

function button_pressed(level, when)
    set_meter(node.random(256) - 1)
end

-- @TODO: set up a tmr to increment the needle up and down

gpio.mode(7, gpio.INT, gpio.PULLUP)
gpio.trig(7, "down", button_pressed)