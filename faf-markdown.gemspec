# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faf/markdown/version'

Gem::Specification.new do |spec|
  spec.name          = "faf-markdown"
  spec.version       = FAF::Markdown::VERSION
  spec.authors       = ["Andrei Istratii"]
  spec.email         = ["andrei.istratii@gmail.com"]
  spec.summary       = %q{APPOO Course Work - 2015.}
  spec.description   = %q{A simple markdown Markdown parser.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "sinatra", "~> 1.4"
  spec.add_runtime_dependency "haml",    "~> 4.0"

  spec.add_development_dependency "bundler",  "~> 1.7"
  spec.add_development_dependency "rake",     "~> 10.0"
  spec.add_development_dependency "rspec",    "~> 3.2"
  spec.add_development_dependency "cucumber", "~> 2.0"
  spec.add_development_dependency "aruba",    "~> 0.6"
end
