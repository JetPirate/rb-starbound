
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rbstarbound/version'

Gem::Specification.new do |spec|
  spec.name          = 'rbstarbound'
  spec.version       = RBStarbound::VERSION
  spec.authors       = ['Oleh Fedorenko']
  spec.email         = ['fpostoleh@gmail.com']

  spec.summary       = 'A simple gem/library for working with Starbound files.'
  spec.homepage      = 'https://github.com/JetPirate/rb-starbound'
  spec.license       = 'MIT'

  spec.files         = Dir['{lib,doc,test}/**/*', 'LICENSE', 'README*']
  spec.test_files    = Dir['{test}/**/*']

  spec.bindir        = 'bin'
  spec.executables   = [spec.name]
  spec.require_paths = ['lib']

  spec.add_dependency('clamp', '~> 1.2.0')

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
