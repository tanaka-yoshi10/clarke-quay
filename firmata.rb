#usr/bin/env ruby 
 
require 'rubygems' 
require 'arduino_firmata' 
 
arduino = ArduinoFirmata.connect "/dev/ttyACM0" 
  
loop do 
  sleep 1 
  arduino.digital_write 13, true 
  sleep 1 
  arduino.digital_write 13, false 
end 
