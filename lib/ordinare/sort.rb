module Ordinare
  class Sort
    def self.sort_gemfile(overwrite = true, path = "Gemfile")
      new(overwrite, path).sort_gemfile
    end

    def self.sort_content(path = "Gemfile", content)
      new(false, path).sort_content(content)
    end

    def initialize(overwrite, path)
      @overwrite = overwrite
      @read_path = path
      @write_path = overwrite ? @read_path : "#{path}.ordinare"
    end

    def sort_gemfile
      unless File.file?(@read_path)
        abort "No Gemfile found in the current directory, is this a Rails project with Gemfile?"
      end

      read_content = File.readlines(@read_path)

      ordered_content = sort_content(read_content)

      write_to_a_file(ordered_content)
    end

    def sort_content(content)
      ranges_to_sort = find_ranges_of_gems(content)

      ranges_to_sort.each do |range|
        content[range[:start_index]..range[:end_index]] =
          content[range[:start_index]..range[:end_index]].sort
      end

      content
    end

    private

    def find_ranges_of_gems(content)
      gems = content.each_with_index.map do |line, index|
        if line.strip.start_with?("gem ")
          index
        end
      end

      ranges_to_sort = []
      gems.each_with_index do |gem, index|
        current_range = if ranges_to_sort.last && !ranges_to_sort.last[:end_index]
                          ranges_to_sort.last
                        else
                          { :start_index => nil, :end_index => nil }
                        end
        start_index = current_range[:start_index]
        end_index = current_range[:end_index]

        if gem && !gems[index - 1] && gems[index + 1]
          current_range[:start_index] = index
          current_range[:end_index] = index if index == gems.length - 1

          ranges_to_sort << current_range unless ranges_to_sort.any? { |range| range[:start_index] == index }
        elsif gem && gems[index - 1] && !gems[index + 1]
          ranges_to_sort.map do |range|
            if range[:start_index] == start_index
              range[:end_index] = index
            end

            range
          end
        end
      end
      ranges_to_sort
    end

    def write_to_a_file(content)
      File.open(@write_path, "w+") do |file|
        content.each { |line| file.puts(line) }
      end

      puts "Your sorted Gemfile can be found at #{@write_path} path"
    end
  end
end
