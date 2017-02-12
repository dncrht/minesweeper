# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minesweeper/version'

Gem::Specification.new do |spec|
  spec.name          = 'minesweeper-cli'
  spec.version       = Minesweeper::VERSION
  spec.authors       = ['Daniel Cruz Horts']
  spec.summary       = %q{A command line, text/emoji minesweeper implementation in Ruby!}
  spec.homepage      = 'https://github.com/dncrht/minesweeper'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
