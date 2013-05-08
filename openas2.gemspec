# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openas2/version'

Gem::Specification.new do |spec|
  spec.name          = "openas2"
  spec.version       = Openas2::VERSION
  spec.authors       = ["Scott Tesoriere"]
  spec.email         = ["scott@tesoriere.com"]
  spec.summary       = %q{Modify openas2 configuration}
  spec.description   = %q{OpenAS2 provides a SSL module to remotely manage it}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency(%q<nokogiri>)

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
