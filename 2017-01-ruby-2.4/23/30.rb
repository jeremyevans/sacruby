require 'net/http'
require 'uri'
url = URI('http://localhost/')
Net::HTTP.start(url.hostname, url.port) do |http|
  http.post(url.path, "q" => "ruby")
end
