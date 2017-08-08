require 'stomp'
require 'json'
@emailclient = Stomp::Connection.open '','',"slave", 61613, true, {'client-id' => "hpustomp"}
@emailclient.publish('/topic/hpumail', {:to => 'email', :token => 'register_confirm.token', :reason => 'register'}.to_json, {:persistent => 'true'})