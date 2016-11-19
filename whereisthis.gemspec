# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'whereisthis/version'

Gem::Specification.new do |spec|
  spec.name          = "whereisthis"
  spec.version       = Whereisthis::VERSION
  spec.authors       = ["Kent Gruber"]
  spec.email         = ["kgruber1@emich.edu"]

  spec.summary       = %q{Help determine country, city, gps coordinates and more from an ip address or url.}
  spec.description   = %q{This gem is meant to provide a tool following unix philosophies. It's meant to be simple, easy to use and straightforward to operate to help determine the location information from a given ip address or url.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.bindir        = "bin"
  spec.executable    = "whereisthis"
  spec.require_paths = ["lib"]

  spec.add_dependency "ipaddress"
  spec.add_dependency "colorize"
  spec.add_dependency "trollop"
  spec.add_dependency "unirest"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
