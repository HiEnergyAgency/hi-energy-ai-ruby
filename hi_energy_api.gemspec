# frozen_string_literal: true

require_relative "lib/hi_energy_api/version"

Gem::Specification.new do |spec|
  spec.name = "hi_energy_api"
  spec.version = HiEnergyApi::VERSION
  spec.authors = [ "Patrick Karsh" ]
  spec.email = [ "patrick@hienergy.ai" ]

  spec.summary = "Ruby client for the Hi Energy AI affiliate marketing API"
  spec.description = "Official Ruby gem for Hi Energy AI REST API v1 (advertisers, deals, contacts, reports, and more)."
  spec.homepage = "https://github.com/HiEnergyAgency/hi_energy_api"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(__dir__) { Dir.glob("lib/**/*") }.select { |f| File.file?(f) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = [ "lib" ]

  spec.add_dependency "faraday", "~> 2.14"
  spec.add_dependency "faraday-net_http", "~> 2.0"
  spec.add_dependency "json", "~> 2.0"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.13"
  spec.add_development_dependency "webmock", "~> 3.23"
end
