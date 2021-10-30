# frozen_string_literal: true

require_relative "lib/pondus/version"

Gem::Specification.new do |spec|
  spec.name = "pondus"
  spec.version = Pondus::VERSION
  spec.authors = ["Liberatys"]
  spec.email = ["nick.flueckiger@renuo.ch"]

  spec.summary = "A scored sorter for rails ActiveRecord models"
  spec.description = "A gem that implements a sort chain that allows for weighted/scored sorting"
  spec.homepage = "https://github.com/Liberatys/pondus"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'https://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Liberatys/pondus"
  spec.metadata["source_code_uri"] = "https://github.com/Liberatys/pondus/CHANGELOG"

  spec.files = `git ls-files`.split("\n")
  spec.test_files = `git ls-files -- {spec}/*`.split("\n")

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "railties", ">= 4.0"
  spec.add_development_dependency "standard", [">= 0"]
  spec.add_development_dependency "simplecov", [">= 0"]
  spec.add_runtime_dependency "activerecord", [">= 5.1.0"]
  spec.add_runtime_dependency "rake", ["~> 13.0"]
  spec.add_runtime_dependency "rspec", ["~> 3.0"]
  spec.add_runtime_dependency "sqlite3", ["~> 1.4"]
end
