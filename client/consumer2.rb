require 'stomp'

client_id = "hpustomp"
subscription_name = "hpustomp"

stomp_params = {
    :hosts => [
    {:host => "master", :port => 61613},
    {:host => "slave", :port => 61613}
    ],
    :connect_headers => {'client-id' => client_id},
    }

client = Stomp::Client.new stomp_params
client.subscribe "/topic/hpumail", {"ack" => "client", "activemq.subscriptionName" =>   subscription_name} do |message|
logstr = "received: #{message.body} on #{message.headers['destination']}"
begin
    puts message.body
    # process(message.body) 
    client.acknowledge message
    rescue Exception => e
        puts "Error #{e}"
    end
end
client.join