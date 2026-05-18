# frozen_string_literal: true

module HiEnergyApi
  module Resources
    class Search < Resource
      def query(q:, **params)
        get("/search", params: params.merge(q: q))
      end
    end
  end
end
