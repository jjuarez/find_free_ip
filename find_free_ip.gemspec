# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'find_free_ip/version'

Gem::Specification.new do |spec|

  spec.name          = "find_free_ip"
  spec.version       = FindFreeIp::VERSION
  spec.authors       = ["Javier Juarez"]
  spec.email         = ["jjuarez@tuenti.com"]

  spec.summary       = "This small tool may help you to find a free IP address in your network"
  spec.description   = "This small tool may help you to find a free IP address in your network"
  spec.homepage      = "https://github.com/jjuare/find_free_ip"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~>0.19.1"
  spec.add_dependency "ipaddress", "~>0.8.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_development_dependency "rspec"
end
