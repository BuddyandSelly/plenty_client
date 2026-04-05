lib = File.expand_path('lib', __dir__)
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

  spec.required_ruby_version = '>= 3.1'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '>= 2.0'
  spec.add_dependency 'faraday-retry', '>= 2.0'
  spec.add_dependency 'faraday-typhoeus', '>= 1.0'
  spec.add_dependency 'json', '>= 2.0'
  spec.add_dependency 'typhoeus', '>= 1.4'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
