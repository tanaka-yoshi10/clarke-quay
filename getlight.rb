#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'date'

def getLightStatus(host, port, id)
  Net::HTTP.version_1_2

  body = ""

  req = Net::HTTP::Get.new("http://#{host}:#{port}/lights/#{id}.json", initheader = {'Content-Type' =>'application/json'})

  Net::HTTP.start(host, port) {|http|
    response = http.request(req)
    body = response.body
  }

  return JSON.parse(body)
end

def postTemperature(host, port, value)
  Net::HTTP.version_1_2

  body = %Q!{ "value" : "#{value}", "mearsured_at" : "#{DateTime.now.to_s}" }!
  puts body
  req = Net::HTTP::Post.new("http://#{host}:#{port}/temperatures", initheader = {'Content-Type' =>'application/json'})
  req.body = body
  Net::HTTP.start(host, port) {|http|
    response = http.request(req)
  }
end

if $0 == __FILE__
  p getLightStatus("192.168.3.1", 3000, "1")
  p postTemperature("192.168.3.1", 3000, "25.1")
end
