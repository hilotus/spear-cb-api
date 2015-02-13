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
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "sucker_punch", "~> 1.0"
  spec.add_development_dependency "rspec"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
