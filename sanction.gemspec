# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sanction/version'

Gem::Specification.new do |spec|
  spec.name          = "sanction"
  spec.version       = Sanction::VERSION
  spec.authors       = ["Adam Carlile", "John Maxwell"]
  spec.email         = ["hello@adamcarlile.com"]
  spec.summary       = "A permissions gem for people who love JSON"
  spec.description   = "Provides a JSON format for describing complex nested permission sets"
  spec.homepage      = "https://github.com/adamcarlile/sanction"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.2"

  spec.add_dependency "activesupport", ">= 7.0"

  spec.add_development_dependency "minitest", ">= 5.25"
  spec.add_development_dependency "rake", "~> 13.0"
end
