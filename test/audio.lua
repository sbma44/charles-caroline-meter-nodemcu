-- ****************************************************************************
-- Play file with pcm module.
--
-- Upload jump_8k.u8 to spiffs before running this script.
--
-- ****************************************************************************

-- set up enable GPIO
gpio.mode(0, gpio.OUTPUT)
gpio.write(0, gpio.LOW)

function cb_drained(d)
  print("drained "..node.heap())
  gpio.write(0, gpio.LOW)

  file.seek("set", 0)
  -- uncomment the following line for continuous playback
  --d:play(pcm.RATE_8K)
end

function cb_stopped(d)
  print("playback stopped")
  file.seek("set", 0)
end

function cb_paused(d)
  print("playback paused")
end

file.open("jump_8k.u8", "r")

drv = pcm.new(pcm.SD, 2)

-- fetch data in chunks of FILE_READ_CHUNK (1024) from file
drv:on("data", function(drv) return file.read() end)

-- get called back when all samples were read from the file
drv:on("drained", cb_drained)

drv:on("stopped", cb_stopped)
drv:on("paused", cb_paused)

-- start playback
gpio.write(0, gpio.HIGH)
drv:play(pcm.RATE_8K)
