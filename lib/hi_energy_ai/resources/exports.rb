# frozen_string_literal: true

module HiEnergyAi
  module Resources
    class Exports < Resource
      def list(**params)
        get("/exports", params: params)
      end

      def find(id, **params)
        get("/exports/#{id}", params: params)
      end

      def create(attributes, **params)
        post("/exports", params: params, body: attributes)
      end
    end
  end
end
