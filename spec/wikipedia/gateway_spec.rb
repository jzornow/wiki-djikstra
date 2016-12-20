require 'wikipedia/gateway'
require 'wikipedia/page'
require 'webmock'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/wikipedia/vcr_cassettes'
  config.hook_into :webmock
end

RSpec.shared_examples 'gateway response' do |keywords, cassette_name|
  let(:response) do
    VCR.use_cassette(cassette_name) do
      Wikipedia::Gateway.new.search_by_keywords(keywords)
    end
  end

  it 'returns an array of Wikipedia::Pages' do
    expect(response).to be_instance_of(Array)
    expect(response.first).to be_instance_of(Wikipedia::Page)
  end

  it 'includes a page that matches the keyword used in the search' do
    titles_returned = response.map(&:title).map(&:downcase)
    expect(titles_returned).to match_array(keywords)
  end
end

describe Wikipedia::Gateway do
  describe 'search_by_keywords' do
    context 'given a single keyword' do
      include_examples(
        'gateway response',
        %w(bacon),
        'single_keyword_search'
      )
    end

    context 'given multiple keywords' do
      include_examples(
        'gateway response',
        %w(bacon eggs),
        'multi_keyword_search'
      )
    end
  end
end
