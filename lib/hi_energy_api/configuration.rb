# frozen_string_literal: true

module HiEnergyApi
  class Configuration
    PRODUCTION_BASE_URL = "https://app.hienergy.ai/api/v1"
    DEFAULT_TIMEOUT = 30

    attr_accessor :api_key, :bearer_token, :base_url, :timeout, :user_agent

    def initialize
      @base_url = PRODUCTION_BASE_URL
      @timeout = DEFAULT_TIMEOUT
      @user_agent = "hi_energy_api/#{HiEnergyApi::VERSION} (Ruby #{RUBY_VERSION})"
    end

    def credentials_present?
      !api_key.to_s.empty? || !bearer_token.to_s.empty?
    end
  end
end
