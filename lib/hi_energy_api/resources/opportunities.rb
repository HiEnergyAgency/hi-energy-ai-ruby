# frozen_string_literal: true

module HiEnergyApi
  module Resources
    class Opportunities < Resource
      def list(**params)
        get("/opportunities", params: params)
      end
    end
  end
end
