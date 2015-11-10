# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bowling_score/version'

Gem::Specification.new do |spec|
  spec.name          = 'bowling_score'
  spec.version       = BowlingScore::VERSION
  spec.authors       = ['Ian Choi']
  spec.email         = ['achiinto@gmail.com']
  spec.summary       = 'Bowling score calculator'
  spec.description   = 'Bowling score calculator support strike and spare rules
                        of rewarding. Taking string as scores.'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep('^bin/') { |f| File.basename(f) }
  spec.test_files    = spec.files.grep('^(test|spec|features)/')
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
