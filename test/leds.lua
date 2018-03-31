NUM_LEDS = 10

ws2812.init()
buf = ws2812.newBuffer(NUM_LEDS, 3)

function random_colors()
    buf:fill(node.random(256) - 1, node.random(256) - 1, node.random(256) - 1)
    ws2812.write(buf)
    tmr.create(1000, tmr.SINGLE_ALARM, random_colors)
end

random_colors()
