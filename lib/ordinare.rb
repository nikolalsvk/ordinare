require "ordinare/version"
require "ordinare/sort"
require "ordinare/check"
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
    check = nil

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

    return if version || help

    if check
      Ordinare::Check.gemfile_sorted?(path)
    else
      Ordinare::Sort.sort_gemfile(overwrite, path)
    end
  end
end
