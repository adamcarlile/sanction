# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sanction/version'

Gem::Specification.new do |spec|
  spec.name          = "sanction"
  spec.version       = Sanction::VERSION
  spec.authors       = ["Adam Carlile", "John Maxwell"]
  spec.email         = ["adam.carlile@boardintelligence.co.uk", "john.maxwell@boardintelligence.co.uk"]
  spec.summary       = "A permissions gem for people who love JSON"
  spec.description   = "Provides a JSON format for describing complex nested permission sets"
  spec.homepage      = "http://github.com/boardiq/sanction"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"

  spec.add_development_dependency "minitest"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "awesome_print"
end
