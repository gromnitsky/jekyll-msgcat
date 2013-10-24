# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll/msgcat/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-msgcat"
  spec.version       = Jekyll::Msgcat::VERSION
  spec.authors       = ["Alexander Gromnitsky"]
  spec.email         = ["alexander.gromnitsky@gmail.com"]
  spec.description   = "Multi-Lingual Interface With Jekyll"
  spec.summary       = "Multi-lingual interface with Jekyll via .yaml message catalogs."
  spec.homepage      = "https://github.com/gromnitsky/jekyll-msgcat"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.3"
  spec.add_dependency "andand", "~> 1.3.3"
  spec.add_dependency "safe_yaml", "~> 0.9.7"

  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rake"
end
