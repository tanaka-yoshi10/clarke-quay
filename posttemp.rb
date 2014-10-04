#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/getlight'

require 'rubygems'
require 'i2c'

class HIH6130

  def initialize(path, address = 0x49)
    @device = I2C.create(path)
    @address = address
  end

  def fetch_humidity_temperature
    s = @device.read(@address, 0x02)
    temp_h, temp_l = s.bytes.to_a
    temp = ((temp_h << 4) + (temp_l >> 4)) * 0.0625

    return temp
  end

end

sensor = HIH6130.new('/dev/i2c-1')

loop do
  temp =  sensor.fetch_humidity_temperature.round(1)
  puts temp
  sleep(10)
  postTemperature("192.168.3.1", 3000, temp)
end
