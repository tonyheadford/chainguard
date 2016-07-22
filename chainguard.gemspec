# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chainguard/version'

Gem::Specification.new do |spec|
  spec.name          = "chainguard"
  spec.version       = Chainguard::VERSION
  spec.authors       = ["Tony Headford"]
  spec.email         = ["tony@binarycircus.com"]

  spec.summary       = %q{Sequence things with optional conditions }
  spec.description   = %q{Provides the ability to link together a sequence of things with conditional guards}
  spec.homepage      = "https://github.com/tonyheadford/chainguard"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "minitest", "~> 5.0"
end
