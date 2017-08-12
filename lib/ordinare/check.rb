module Ordinare
  class Check
    def self.gemfile_sorted?(path = "Gemfile")
      new(path).gemfile_sorted?
    end

    def initialize(path)
      @path = path
    end

    def gemfile_sorted?
      unless File.file?(@path)
        abort "No Gemfile found in the current directory, is this a Rails project with Gemfile?"
      end

      ordered_content = Ordinare::Sort.sort_content(@path, File.readlines(@path))

      read_content = File.readlines(@path)

      if read_content == ordered_content
        puts "Gemfile is sorted properly"
        true
      else
        abort "Gemfile is not sorted"
      end
    end
  end
end
