lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'plenty_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'plenty_client'
  spec.version       = PlentyClient::VERSION
  spec.authors       = ['Dariusch Ochlast']
  spec.email         = ['dariusch.ochlast@gmail.com']

  spec.summary       = 'This the first draft of a PlentyMarkets Rest Client for Ruby.'
  spec.description   = 'This is a simple client for the PlentyMarkets REST API providing classes to interact with it.'
  spec.homepage      = 'https://github.com/Dariusch/plenty_client'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 3.1.0'
  
  spec.add_development_dependency 'bundler', '~> 2.7'
  spec.add_development_dependency 'rake', '~> 13.3'
  spec.add_development_dependency 'rspec', '~> 3.13'
  spec.add_development_dependency 'webmock', '~> 3.25'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'pry', '~> 0.15'
  spec.add_development_dependency 'byebug', '~> 12.0'

  spec.add_runtime_dependency 'json', '~> 2.0'
  spec.add_runtime_dependency 'faraday', '~> 2.13'
  spec.add_runtime_dependency 'faraday-typhoeus', '~> 1.1'
  spec.add_runtime_dependency 'faraday-retry', '~> 2.3'
  spec.add_runtime_dependency 'typhoeus', '~> 1.4'
  
  # Rails 8 compatibility
  spec.add_development_dependency 'rails', '~> 8.0'
end
