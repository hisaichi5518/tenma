# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tenma/version"

Gem::Specification.new do |spec|
  spec.name          = "tenma"
  spec.version       = Tenma::VERSION
  spec.authors       = ["hisaichi5518"]
  spec.email         = ["hisaichi5518@gmail.com"]

  spec.summary       = %q{Tenma is command line tool for mobile application development.}
  spec.description   = %q{Tenma is command line tool for mobile application development.}
  spec.homepage      = "https://github.com/hisaichi5518/tenma"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor'
  spec.add_dependency 'octokit'
  spec.add_dependency 'hashie'
  spec.add_dependency 'git'
  spec.add_dependency 'itamae'

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
