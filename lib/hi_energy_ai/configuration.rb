# frozen_string_literal: true

module HiEnergyAi
  class Configuration
    APP_ORIGIN = "https://app.hienergy.ai"
    API_BASE_URL = "https://app.hienergy.ai/api/v1"
    DOCUMENTATION_URL = "https://app.hienergy.ai/api_documentation"
    DEFAULT_TIMEOUT = 30

    # Environment preset. Spread into `HiEnergyAi.new` so callers don't
    # have to hard-code hostnames:
    #
    #   HiEnergyAi.new(api_key: k, **HiEnergyAi::Configuration::PRODUCTION)
    PRODUCTION = {
      app_origin: APP_ORIGIN,
      base_url: API_BASE_URL
    }.freeze

    attr_accessor :api_key, :bearer_token, :base_url, :app_origin, :timeout, :user_agent, :dry_run

    alias_method :server_dry_run, :dry_run
    alias_method :server_dry_run=, :dry_run=

    def initialize
      @app_origin = APP_ORIGIN
      @base_url = API_BASE_URL
      @timeout = DEFAULT_TIMEOUT
      @dry_run = false
      @user_agent = "hi_energy_ai/#{HiEnergyAi::VERSION} (Ruby #{RUBY_VERSION})"
    end

    def credentials_present?
      !api_key.to_s.empty? || !bearer_token.to_s.empty?
    end
  end
end
