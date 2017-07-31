require "ordinare/version"
require "optparse"

module Ordinare
  module_function

  def hi
    "Ciao, sono Ordinare"
  end

  def parse_args
    OptionParser.new do |opts|
      opts.banner = "Usage: ordinare inside your Rails project"

      opts.on("-pFILE", "--path=FILE", "Order file") do |filename|
        Ordinare.sort(filename)
      end

      opts.on("-v", "--version", "Check gem version") do
        puts Ordinare::VERSION
      end

      opts.on("-h", "--help", "Get help") do
        puts opts
      end
    end.parse!
  end

  def sort(path = "Gemfile")
    unless File.file?(path)
      abort("No Gemfile found in the current directory, is this a Rails project with Gemfile?")
    end

    content = File.readlines(path)

    ranges_to_sort = find_ranges_of_gems(content)

    ranges_to_sort.each do |range|
      content[range[:start_index]..range[:end_index]] =
        content[range[:start_index]..range[:end_index]].sort
    end

    File.open("#{path}.ordinare", "w+") do |file|
      content.each { |line| file.puts(line) }
    end
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

      if gem && !gems[index - 1]
        current_range[:start_index] = index

        ranges_to_sort << current_range
      elsif gem && gems[index - 1] && !gems[index + 1]
        ranges_to_sort.map do |range|
          range[:start_index] == start_index ? current_range[:end_index] = index : range
          range
        end
      end
    end
    ranges_to_sort
  end
end
