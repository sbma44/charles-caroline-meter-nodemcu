function set_meter(b)
    if b == 0 then
        cycle_meter()
    else
        gpio.serout(5, gpio.HIGH, { 10000 }, b, cycle_meter)
    end
end

function cycle_meter()
    gpio.write(5, gpio.LOW);
    gpio.serout(6, gpio.HIGH, { 1000 }, 1, function() gpio.write(6, gpio.LOW); print("cycled meter"); end)
end

val = 0
function do_increment()
    set_meter(val)
    val = (val + 10) % 256
end

--tmr.alarm(1, 1000, tmr.ALARM_AUTO, do_increment)
