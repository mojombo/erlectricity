require 'rubygems'
require 'erlectricity'
require 'stringio'

receive do |f|
  f.when(:echo, String) do |text|
    f.send!(:result, "You said: #{text}")
    f.receive_loop
  end
end