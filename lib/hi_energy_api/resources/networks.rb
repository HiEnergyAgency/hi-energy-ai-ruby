# frozen_string_literal: true

module HiEnergyApi
  module Resources
    class Networks < Resource
      def list(**params)
        get("/networks", params: params)
      end

      def find(id, **params)
        get("/networks/#{id}", params: params)
      end
    end
  end
end
