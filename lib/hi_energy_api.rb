# frozen_string_literal: true

require "json"

require_relative "hi_energy_api/version"
require_relative "hi_energy_api/error"
require_relative "hi_energy_api/configuration"
require_relative "hi_energy_api/response"
require_relative "hi_energy_api/paginator"
require_relative "hi_energy_api/resource"
require_relative "hi_energy_api/client"

Dir[File.join(__dir__, "hi_energy_api/resources", "*.rb")].sort.each { |file| require file }

module HiEnergyApi
  class << self
    def new(**options)
      Client.new(**options)
    end

    def configure(&block)
      Client.configure(&block)
    end

    def documentation_url
      Configuration::DOCUMENTATION_URL
    end
  end
end
