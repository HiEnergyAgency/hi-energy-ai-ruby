# frozen_string_literal: true

module HiEnergyApi
  module Resources
    class Deals < Resource
      def list(**params)
        get("/deals", params: params)
      end

      def find(id, **params)
        get("/deals/#{id}", params: params)
      end

      def types(**params)
        get("/deals/types", params: params)
      end

      def translate(id, **params)
        post("/deals/#{id}/translate", params: params)
      end
    end
  end
end
