# frozen_string_literal: true

module HiEnergyApi
  module Resources
    class Tools < Resource
      def list(**params)
        get("/tools", params: params)
      end
    end
  end
end
