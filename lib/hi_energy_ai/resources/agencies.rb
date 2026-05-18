# frozen_string_literal: true

module HiEnergyAi
  module Resources
    class Agencies < Resource
      def list(**params)
        get("/agencies", params: params)
      end

      def find(id, **params)
        get("/agencies/#{id}", params: params)
      end
    end
  end
end
