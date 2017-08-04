require "ordinare/version"
require "optparse"

module Ordinare
  module_function

  def hi
    "Ciao, sono Ordinare"
  end

  def parse_args
    path = "Gemfile"
    overwrite = true
    version = nil
    help = nil

    OptionParser.new do |opts|
      opts.banner = "Usage: ordinare inside your Rails project"
      opts.separator ""
      opts.separator "Specific options:"

      opts.on("-pFILE", "--path=FILE", "Order file") do |filename|
        path = filename
      end

      opts.on("-n", "--no-overwrite", "Don't overwrite Gemfile") do
        overwrite = false
      end

      opts.on("-v", "--version", "Check gem version") do
        puts Ordinare::VERSION
        version = true
      end

      opts.on("-h", "--help", "Get help") do
        puts opts
        help = true
      end
    end.parse!

    Ordinare.sort(overwrite, path) unless version || help
  end

  def sort(overwrite = true, path = "Gemfile")
    unless File.file?(path)
      abort("No Gemfile found in the current directory, is this a Rails project with Gemfile?")
    end

    content = File.readlines(path)

    ranges_to_sort = find_ranges_of_gems(content)

    ranges_to_sort.each do |range|
      content[range[:start_index]..range[:end_index]] =
        content[range[:start_index]..range[:end_index]].sort
    end

    path = "#{path}.ordinare" unless overwrite

    File.open(path, "w+") do |file|
      content.each { |line| file.puts(line) }
    end

    puts "Your sorted Gemfile can be found at #{path} path"
  end

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
end
