NUM_LEDS = 14

ws2812.init()
buf = ws2812.newBuffer(NUM_LEDS, 3)

function random_colors()
    buf:fill(node.random(256) - 1, node.random(256) - 1, node.random(256) - 1)
    ws2812.write(buf)
    print('wrote buf')
end

tmr.alarm(0, 1000, tmr.ALARM_AUTO, random_colors)
