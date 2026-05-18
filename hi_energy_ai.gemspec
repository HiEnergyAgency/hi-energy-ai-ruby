# frozen_string_literal: true

require_relative "lib/hi_energy_ai/version"

Gem::Specification.new do |spec|
  spec.name = "hi_energy_ai"
  spec.version = HiEnergyAi::VERSION
  spec.authors = [ "Patrick Karsh" ]
  spec.email = [ "patrick@hienergy.ai" ]

  spec.summary = "Official Ruby client for the Hi Energy AI affiliate marketing API"
  spec.description = <<~DESC.strip
    Ruby gem for the Hi Energy AI REST API v1 at https://app.hienergy.ai/api/v1.
    Covers advertisers, deals, contacts, transactions, reports, universal search,
    MCP bootstrap, and OpenAPI schema discovery. See https://app.hienergy.ai/api_documentation.
  DESC
  spec.homepage = "https://github.com/HiEnergyAgency/hi_energy_api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["documentation_uri"] = "https://app.hienergy.ai/api_documentation"
  spec.metadata["changelog_uri"] = "https://github.com/HiEnergyAgency/hi_energy_ai/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(__dir__) do
    Dir.glob("{lib/**/*,README.md,CHANGELOG.md,LICENSE.txt}", File::FNM_DOTMATCH)
      .select { |path| File.file?(path) }
  end

  spec.require_paths = [ "lib" ]

  spec.add_dependency "faraday", "~> 2.14"
  spec.add_dependency "faraday-net_http", "~> 2.0"
  spec.add_dependency "json", "~> 2.0"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.13"
  spec.add_development_dependency "webmock", "~> 3.23"
end
