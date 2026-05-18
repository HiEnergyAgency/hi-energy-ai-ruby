# frozen_string_literal: true

module HiEnergyAi
  module Resources
    class Reports < Resource
      def list(**params)
        get("/reports", params: params)
      end

      def find(id, **params)
        get("/reports/#{id}", params: params)
      end
    end
  end
end
