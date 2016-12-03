module Wikipedia
  # builds a request URI from a list of keywords
  class RequestBuilder
    BASE_URI = 'https://en.wikipedia.org/w/api.php'  \
               '?action=query' \
               '&prop=revisions' \
               '&rvprop=content' \
               '&format=json' \
               '&titles='.freeze

    def self.uri_from(search_terms)
      URI.parse "#{BASE_URI}#{params_from_keywords(search_terms)}"
    end

    def self.params_from_keywords(array_of_keywords)
      # keywords are separated by pipes ('|') and all spaces are replaced
      # with underscores
      unencoded = array_of_keywords.join('|').gsub(/\s/, '_')

      # technically not all characters *need* to be encoded, but the API will
      # unescape entirely-encoded strings as needed
      URI.encode unencoded, /\S/
    end
  end
end
