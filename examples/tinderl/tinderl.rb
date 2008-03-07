$:.unshift(File.dirname(__FILE__) + "/../../lib/")
require 'erlectricity'
require 'rubygems'
require 'tinder'

domain, email, password, room_name = *ARGV
campfire = Tinder::Campfire.new domain
campfire.login email, password
room = campfire.find_room_by_name room_name

receive do |f|
  f.when(:speak, Any) do |comment|
    room.speak comment
    f.receive_loop
  end 
  
  f.when(:paste, Any) do |comment|
    room.paste comment
    f.receive_loop
  end
  
  f.when(Any) do |obj|
    STDERR.write obj.inspect
  end
end

room.leave if room
