erlectricity
  by Scott Fleckenstein
     Tom Preston-Werner
     
     http://github.com/mojombo/erlectricity
     
== DESCRIPTION:

Erlectricity allows a Ruby program to receive and respond to Erlang messages
sent over the Erlang binary protocol.

== INSTALL:

$ gem install erlectricity

-or-

$ gem install mojombo-erlectricity -s http://gems.github.com

== CONTRIBUTE:

Contributions are welcome via GitHub! Fork the code from
http://github.com/mojombo/erlectricity and send a pull request to mojombo.

== USAGE (Ruby side):

require 'rubygems'
require 'erlectricity'

receive do |f|
  f.when(:echo, String) do |text|
    f.send!(:result, "You said: #{text}")
    f.receive_loop
  end
end

== USAGE (Erlang side):

-module(echo).
-export([test/0]).

test() ->
  Cmd = "ruby echo.rb",
  Port = open_port({spawn, Cmd}, [{packet, 4}, use_stdio, exit_status, binary]), 
  Payload = term_to_binary({echo, <<"hello world!">>}),
  port_command(Port, Payload),
  receive
    {Port, {data, Data}} ->
      {result, Text} = binary_to_term(Data),
      io:format("~p~n", [Text])
  end.