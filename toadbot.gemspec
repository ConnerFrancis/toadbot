# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "toadbot/version"

Gem::Specification.new do |spec|
  spec.name          = "toadbot"
  spec.version       = Toadbot::VERSION
  spec.authors       = ["kumo"]
  spec.email         = ["thxbro79@gmail.com"]

  spec.summary       = %q{toadbot is a simple discord bot built in ruby.}
  spec.description   = %q{toadbot is a simple discord bot built in ruby with the discordrb library and sql.}
  spec.homepage      = "https://github.com/ConnerFrancis/toadbot"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "discordrb", "~> 3.2"
  spec.add_runtime_dependency "discordrb", "~> 3.2"
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_runtime_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency "sequel", "~> 5.1"
  spec.add_runtime_dependency "sequel", "~> 5.1"
end
