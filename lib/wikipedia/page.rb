module Wikipedia
  # Representation of a Wikipedia Page for link extraction and comparison
  class Page
    attr_reader :title

    def initialize(opts = {})
      @title = opts[:title]
      @content = opts[:content]
    end

    def missing?
      # in case it was a dead link
      @content.nil?
    end

    def ==(other)
      title == other.title
    end

    def links
      @links ||= if missing?
                   []
                 else
                   @content.scan(/(?<=\[\[)(?![a-zA-Z]*\:)[^\]\|\#]+/)
                 end
    end
  end
end
