module Djikstra
  # a node with knowledge of those nodes what came before it
  class Path
    attr_reader :title, :parent, :distance

    def initialize(title, opts = {})
      @title = title
      @parent = opts[:parent]
      @distance = opts[:distance] || 0
    end

    def ==(other)
      [self, other].map(&:title).map(&:downcase).reduce(:==)
    end

    def to_s
      if parent
        "#{parent} > #{title}"
      else
        title
      end
    end
  end
end
