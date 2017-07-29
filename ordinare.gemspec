# coding: utf-8

lib = File.expand_path("../lib/", __FILE__)
$:.unshift lib unless $:.include?(lib)
require "ordinare/version"

Gem::Specification.new do |s|
  s.name          = "ordinare"
  s.version       = Ordinare::VERSION
  s.licenses      = ["MIT"]
  s.summary       = "Sort your gems in Gemfile with ease"
  s.description   = "Ordinare sorts gems in your Gemfile alphabetically"
  s.authors       = ["Nikola Đuza"]
  s.email         = "nikolaseap@gmail.com"
  s.files         = Dir['lib/**/*.rb']
  s.homepage      = "https://github.com/nikolalsvk/ordinare"
  s.executables   = "ordinare"

  s.add_development_dependency "rspec", "~> 3.6", ">= 3.6"
end
