require './lib/wikipedia/page'
require 'json'

module Wikipedia
  # For extracting pages from API Response
  class Response
    def initialize(response)
      @page_data = JSON.parse(response.body)['query']['pages'].values
    end

    def pages
      @pages ||= extract_pages_from_response
    end

    private

    def extract_pages_from_response
      @page_data.each_with_object([]) do |raw_page, repo|
        repo << Page.new(
          title: raw_page['title'],
          content: content_from(raw_page)
        )
      end
    end

    def content_from(raw_page)
      raw_page['revisions'].first['*']
    rescue
      # in case 'revisions' is not present
      nil
    end
  end
end
