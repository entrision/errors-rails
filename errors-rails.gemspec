require_relative 'lib/errors/ror/version'

Gem::Specification.new do |spec|
  spec.name          = "errors_ror"
  spec.version       = Errors::Ror::VERSION
  spec.authors       = ["Robert D. Cotey II"]
  spec.email         = ["rcotey@entrision.com"]

  spec.summary       = %q{Gem to use with error reporting server for Entrision}
  spec.homepage      = "https://github.com/entrision/errors-rails"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")


  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/entrision/errors-rails"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
