require './lib/wikipedia/request_builder'

describe Wikipedia::RequestBuilder do
  describe 'uri_from' do
    context 'given a series of search terms' do
      let(:search_terms) { ['word', 'a short phrase'] }

      let(:uri) { RequestBuilder.uri_from(search_terms) }

      it 'creates a uri' do
        expect(uri).to be_instance_of(URI::HTTPS)
      end

      it 'encodes those search terms' do
        expected_params = uri.to_s.split('=').last
        actual_params = RequestBuilder.params_from_keywords(search_terms)

        expect(expected_params).to eq actual_params
      end

      it 'attaches those search terms to the base uri' do
        expect(uri.to_s).to start_with(RequestBuilder::BASE_URI)
      end
    end
  end

  describe 'params_from_keywords' do
    context 'given a single search term with only letters' do
      it 'returns that search term with each letter encoded' do
        search_term = 'word'

        expect(RequestBuilder.params_from_keywords([search_term]))
          .to eq URI.encode(search_term, /\S/)
      end
    end

    context 'given a single search term with spaces' do
      it 'returns that search term encoded, but with spaces replaced' do
        search_term = 'words with spaces'
        expected_search_string = search_term.gsub(/\s/, '_')

        expect(RequestBuilder.params_from_keywords([search_term]))
          .to eq URI.encode(expected_search_string, /\S/)
      end
    end

    context 'given multiple search terms' do
      it 'returns those terms w/o spaces, joined by pipes, all encoded' do
        search_terms = ['words with spaces', 'single']
        expected_search_string = search_terms.join('|').gsub(/\s/, '_')

        expect(RequestBuilder.params_from_keywords(search_terms))
          .to eq URI.encode(expected_search_string, /\S/)
      end
    end
  end
end
