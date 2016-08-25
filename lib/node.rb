class Node
  attr_reader :url, :neighbors

  def initialize(opts)
    @url = opts[:url]
    @neighbors = opts[:neighbors] || []
  end
end
