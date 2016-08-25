require 'node'
require 'faker'

describe Node do
  describe 'add_neighbor' do
    context 'given another noded added as a neighbor' do
      before do
        @home = Node.new(url: random_url)
        @neighbor = Node.new(url: random_url)

        @home.neighbors << @neighbor
      end

      it('recognizes its neighbor') do
        expect(@home.neighbors.include?(@neighbor)).to eq(true)
      end
    end
  end

  def random_url
    Faker::Internet.url('example.com')
  end
end
