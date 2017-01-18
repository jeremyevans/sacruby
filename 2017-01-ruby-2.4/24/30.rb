require 'net/http'
require 'uri'
Net::HTTP.post(URI('http://localhost/'), {"q" => "ruby"})
