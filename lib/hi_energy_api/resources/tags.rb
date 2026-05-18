# frozen_string_literal: true

module HiEnergyApi
  module Resources
    class Tags < Resource
      def list(**params)
        get("/tags", params: params)
      end

      def advertisers(id, **params)
        get("/tags/#{id}/advertisers", params: params)
      end
    end
  end
end
