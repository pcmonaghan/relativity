require "net/http"
require "uri"
require "json"

base_url = 'https://datascience.wufoo.com/api/v3/'
username = ENV['WUFOO_API_KEY']
password = 'footastic'

uri = URI.parse(base_url+"forms/s1m602cl14eekx9/webhooks.json")

request = Net::HTTP::Put.new(uri.request_uri)
request.basic_auth(username, password)

request.set_form_data('url' => 'http://wufoo.relativity.ultrahook.com',
                      'handshakeKey' => '43-62-11-8e-d1-c7-ef-8c-1f-2e',
                      'metadata' => 'true'
                      )

response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
  http.request(request)
}

puts JSON.pretty_generate(JSON[response.body])
