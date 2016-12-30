require "net/http"
require "uri"
require "json"

base_url = 'https://datascience.wufoo.com/api/v3/'
username = ENV['WUFOO_API_KEY']
password = 'footastic'

uri = URI.parse(base_url+"forms/s1m602cl14eekx9/fields.json")

request = Net::HTTP::Get.new(uri.request_uri)
request.basic_auth(username, password)


response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
  http.request(request)
}

for JSON.pretty_generate(JSON[response.body])['Fields']

puts JSON.pretty_generate(JSON[response.body])
