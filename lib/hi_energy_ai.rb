# frozen_string_literal: true

require "json"

require_relative "hi_energy_ai/version"
require_relative "hi_energy_ai/error"
require_relative "hi_energy_ai/configuration"
require_relative "hi_energy_ai/response"
require_relative "hi_energy_ai/paginator"
require_relative "hi_energy_ai/resource"
require_relative "hi_energy_ai/client"

Dir[File.join(__dir__, "hi_energy_ai/resources", "*.rb")].sort.each { |file| require file }

module HiEnergyAi
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
