require 'djikstra/path'
include Djikstra

describe Path do
  describe :equals do
    context 'given two paths with no parents' do
      it 'returns true if title is the same' do
        original = Path.new('Some Title')
        same = Path.new('Some Title')

        expect(original == same).to be true
      end

      it 'returns false if title is not the same' do
        original = Path.new('Some Title')
        other = Path.new('Some Other Title')

        expect(original == other).to be false
      end

      context 'given two paths at the end of a chain parent' do
        it 'returns true if the last title is the same' do
          original = path_from_strings('Several', 'Separate', 'Titles')
          same = path_from_strings('Some', 'Different', 'Titles')

          expect(original == same).to be true
        end

        it 'returns false if the last title is not same' do
          original = path_from_strings('Several', 'Separate', 'Titles')
          other = path_from_strings('Not', 'Gonna', 'Match')

          expect(original == other).to be false
        end
      end
    end

    describe :to_s do
      context 'given a path of length 1' do
        it 'returns the title' do
          path = Path.new('Some Title')

          expect(path.to_s).to eq path.title
        end
      end

      context 'given a path with some parents' do
        it 'returns the titles of path and all parents' do
          titles = %w(Some Multi Part Title)

          path = path_from_strings(*titles)
          expected_string = titles.join(' > ')

          expect(path.to_s).to eq expected_string
        end
      end
    end
  end

  private

  def path_from_strings(*strings)
    strings.reduce(nil) do |memo, current|
      Path.new(current, parent: memo)
    end
  end
end
