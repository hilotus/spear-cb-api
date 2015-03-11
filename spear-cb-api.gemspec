# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spear/version'

Gem::Specification.new do |spec|
  spec.name          = "spear-cb-api"
  spec.version       = Spear::VERSION
  spec.authors       = ["CBluowei"]
  spec.email         = ["wei.luo@careerbuilder.com"]
  spec.summary       = %q{Cb api wrapper}
  spec.description   = %q{This gem include api wrapper, response structure and dummy data.}
  spec.homepage      = "https://github.com/hilotus/spear-cb-api"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 2.1.0'

  spec.add_dependency "builder", "~> 3.2"
  spec.add_dependency "activesupport", "~> 4.2"
  spec.add_dependency "activemodel", "~> 4.2"
  spec.add_dependency "sucker_punch", "~> 1.4"
  spec.add_dependency "httparty", "~> 0.13"

  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "pry-stack_explorer", "~> 0.4"
  spec.add_development_dependency "pry-byebug", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.4"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end
