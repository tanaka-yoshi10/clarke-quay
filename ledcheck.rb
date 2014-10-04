#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/getlight'

GPIO = 24

exp = open("/sys/class/gpio/export", "w")
exp.write(GPIO)
exp.close
 
begin
  dir = open("/sys/class/gpio/gpio#{GPIO}/direction", "w")
  dir.write("out")
  dir.close
 
  out = 1
  loop do
    status = getLightStatus("192.168.3.1", 3000, "1")["status"]
    puts status
    val = open("/sys/class/gpio/gpio#{GPIO}/value", "w")
    val.write(out)
    val.close
    out = status.to_i
    sleep 1
  end
 
ensure
  puts "end"
  uexp = open("/sys/class/gpio/unexport", "w")
  uexp.write(GPIO)
  uexp.close
end
