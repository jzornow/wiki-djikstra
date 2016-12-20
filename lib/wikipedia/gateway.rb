require 'net/http'
require 'uri'
require 'openssl'
require 'json'

require './lib/wikipedia/response'
require './lib/wikipedia/request_builder'

module Wikipedia
  # For actually making API calls to Wikipedia
  class Gateway
    # The limit as imposed by the Wikimedia API
    # => TODO: Register app as a high-api-limit bot for better bandwidth
    BATCH_SIZE = 49

    def search_by_keywords(*keywords)
      pages = []

      keywords.each_slice(BATCH_SIZE) do |batch_of_keywords|
        request = RequestBuilder.uri_from(batch_of_keywords)
        response = get request

        pages += response.pages
      end

      pages
    end

    private

    def get(request)
      http = Net::HTTP.new(request.host, request.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      Response.new http.get(request.request_uri)
    end
  end
end
