#!/usr/bin/env ruby

require 'net/http'
require 'json'

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

if $0 == __FILE__
  p getLightStatus("192.168.3.1", 3000, "1")
end
