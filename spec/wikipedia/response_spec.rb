require './lib/wikipedia/response'

include Wikipedia

describe Response do
  def create_mock_response_from(response_body)
    allow(raw_response = double)
      .to receive(:body)
      .and_return(response_body)

    raw_response
  end

  def mock_response_with(title, content)
    create_mock_response_from %({
      "query":{
        "pages":{
          "1":{
            "title":"#{title}",
            "revisions":[{"*":"#{content}"}]
          }
        }
      }
    })
  end

  def mock_blank_response_with(title)
    create_mock_response_from %({
      "query":{
        "pages":{
          "1":{
            "title":"#{title}"
          }
        }
      }
    })
  end

  context 'given a response with a page with content' do
    let(:page_title) { 'Page w/ Content' }

    let(:response_page) do
      raw_response = mock_response_with page_title, 'Some Content'
      Response.new(raw_response).pages.first
    end

    it 'converts that response into a page object' do
      expect(response_page).to be_a(Wikipedia::Page)
    end

    it "preserves that page's title" do
      expect(response_page.title).to eq page_title
    end

    it "preserves that page's content" do
      expect(response_page.missing?).to be false
    end
  end

  context 'given a response with a page w/o content' do
    it 'creates a page object w/o content' do
      raw_response = mock_blank_response_with 'Empty Page'

      response_page = Response.new(raw_response).pages.first
      expect(response_page.missing?).to be true
    end
  end
end
