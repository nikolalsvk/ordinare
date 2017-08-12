module Ordinare
  class Check
    def self.gemfile_sorted?(path = "Gemfile")
      new(path).gemfile_sorted?
    end

    def initialize(path)
      @path = path
    end

    def gemfile_sorted?

    end
  end
end
