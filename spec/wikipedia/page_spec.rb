require 'wikipedia/page'
include Wikipedia

describe Page do
  describe 'missing?' do
    context 'given a page with no content' do
      it 'returns true' do
        no_content = Page.new(title: 'Empty Page', content: nil)
        expect(no_content.missing?).to be true
      end
    end

    context 'given a page with content' do
      it 'returns false' do
        page_with_content = Page.new(title: 'Normal Page', content: 'asdf')
        expect(page_with_content.missing?).to be false
      end
    end
  end

  describe '==' do
    context 'given two pages with the same title' do
      it 'returns true' do
        one = Page.new(title: 'Title')
        two = Page.new(title: 'Title')

        expect(one).to eq two
      end
    end

    context 'given two pages with different names' do
      it 'returns false' do
        one = Page.new(title: 'Title')
        two = Page.new(title: 'Other')

        expect(one).not_to eq two
      end
    end
  end

  describe 'links' do
    context 'given a page with no content' do
      it 'returns an empty set' do
      end
    end

    context 'given a page with content' do
      it 'returns basic strings enclosed in double square brackets' do
        page_content = 'This is a [[link]]. This is [[another]].'
        page = Page.new(content: page_content)

        expect(page.links).to include('link', 'another')
      end

      it 'does not return strings with prefixes' do
        page_content = %(This is a [[prefixed: link]].
                         This is [[prefixed: another]].)

        page = Page.new(content: page_content)

        expect(page.links).to_not include 'link', 'another'
      end

      it "returns only the substring before a '\#'" do
        page_content = 'This is a [[string with#a pound sign]]'
        page = Page.new(content: page_content)

        expect(page.links).to include 'string with'
        expect(page.links).to_not include 'a pound sign'
      end

      it "returns only the substring before a '|'" do
        page_content = 'This is a [[string with|a pipe]]'
        page = Page.new(content: page_content)

        expect(page.links).to include 'string with'
        expect(page.links).to_not include 'a pipe'
      end
    end
  end
end
