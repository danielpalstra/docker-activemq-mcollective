# -*- encoding: utf-8 -*-

require 'rubygems'
require 'stomp'
#
# == Example message consumer.
#
class ExampleConsumer
  # Initialize.
  def initialize; end

  # Run example.
  def run
    # client = Stomp::Client.new('failover://(stomp://:@localhost:61613,stomp://:@remotehost:61613)?initialReconnectDelay=5000&randomize=false&useExponentialBackOff=false')
    # single
    # client = Stomp::Client.new('stomp://:@localhost:61613')
    client = Stomp::Client.new('stomp://:@master:61613')
    # multiple
    # client = Stomp::Client.new('failover://(stomp://:@master:61613,stomp://:@slave:61613)')


    puts 'Subscribing ronaldo'
    client.subscribe('/queue/ronaldo', :ack => 'client',
     'activemq.prefetchSize' => 1,
     'activemq.exclusive' => true) do |msg|
      File.open('file', 'a') do |f|
        puts(msg.body)
        puts("\n----------------\n")
      end

      client.acknowledge(msg)
    end

    loop do
      sleep(5)
      puts '.'
    end
  end
end
#
e = ExampleConsumer.new
e.run
