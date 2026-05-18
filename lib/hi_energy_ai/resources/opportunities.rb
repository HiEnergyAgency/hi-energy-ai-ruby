# frozen_string_literal: true

module HiEnergyAi
  module Resources
    class Opportunities < Resource
      def list(**params)
        get("/opportunities", params: params)
      end
    end
  end
end
