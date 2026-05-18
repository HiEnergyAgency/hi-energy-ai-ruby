# frozen_string_literal: true

module HiEnergyApi
  module Resources
    class Schema < Resource
      def fetch(**params)
        get("/schema", params: params)
      end
    end
  end
end
