# frozen_string_literal: true

module HiEnergyAi
  module Resources
    class Schema < Resource
      def fetch(**params)
        get("/schema", params: params)
      end
    end
  end
end
