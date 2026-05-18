# frozen_string_literal: true

module HiEnergyAi
  module Resources
    class Domains < Resource
      def search(domain:, **params)
        get("/domains/search", params: params.merge(domain: domain))
      end
    end
  end
end
