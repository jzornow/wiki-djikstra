require './lib/djikstra/path'

module Djikstra
  # Carries out the algorithm using a gateway object, a start, and an end
  class Runner
    def initialize(gateway)
      @gateway = gateway
      @visited_paths = []
    end

    def find(start_page:, end_page:)
      start_path, end_path = paths_from [start_page, end_page]
      @unvisited_paths = [start_path]

      loop do
        @unvisited_paths.each_slice(@gateway.class::BATCH_SIZE) do |paths|
          pages_from(paths).each do |page|
            parent_path = find_page_parent(page, paths)
            mark_as_visited(parent_path)
            paths_from(page.links, parent_path).each do |path|
              puts path
              return path if path == end_path
              add_to_univisted(path)
            end
          end
        end
      end
    end

    private

    attr_reader :unvisited_paths, :visited_paths

    def pages_from(paths)
      @gateway.search_by_keywords paths.map(&:title)
    end

    def add_to_univisted(path)
      @unvisited_paths << path
      @unvisited_paths.uniq
    end

    def mark_as_visited(path)
      @visited_paths << path
      @unvisited_paths.delete(path)
    end

    def find_page_parent(page, paths)
      paths.find do |path|
        # if equal after checking downcase'd titles
        [path, page].map(&:title).map(&:downcase).reduce(:==)
      end
    end

    def paths_from(links, parent_path = nil)
      links.map do |link|
        Djikstra::Path.new(link, parent: parent_path)
      end
    end
  end
end
