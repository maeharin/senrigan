# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'senrigan/version'

Gem::Specification.new do |spec|
  spec.name          = "senrigan"
  spec.version       = Senrigan::VERSION
  spec.authors       = ["Hidenori Maehara"]
  spec.email         = ["maeharin@gmail.com"]
  spec.summary       = "Dependency visualizer like JSP etc.."
  spec.homepage      = "https://github.com/maeharin/senrigan"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "ruby-graphviz"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
