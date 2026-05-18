# frozen_string_literal: true

module HiEnergyApi
  class Configuration
    APP_ORIGIN = "https://app.hienergy.ai"
    API_BASE_URL = "https://app.hienergy.ai/api/v1"
    DOCUMENTATION_URL = "https://app.hienergy.ai/api_documentation"
    DEFAULT_TIMEOUT = 30

    attr_accessor :api_key, :bearer_token, :base_url, :app_origin, :timeout, :user_agent, :dry_run

    def initialize
      @app_origin = APP_ORIGIN
      @base_url = API_BASE_URL
      @timeout = DEFAULT_TIMEOUT
      @dry_run = false
      @user_agent = "hi_energy_api/#{HiEnergyApi::VERSION} (Ruby #{RUBY_VERSION})"
    end

    def credentials_present?
      !api_key.to_s.empty? || !bearer_token.to_s.empty?
    end
  end
end
