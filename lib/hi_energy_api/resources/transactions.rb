# frozen_string_literal: true

module HiEnergyApi
  module Resources
    class Transactions < Resource
      def list(**params)
        get("/transactions", params: params)
      end

      def find(id, **params)
        get("/transactions/#{id}", params: params)
      end
    end
  end
end
