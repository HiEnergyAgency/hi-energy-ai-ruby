# frozen_string_literal: true

module HiEnergyApi
  module Resources
    class Verticals < Resource
      def list(**params)
        get("/verticals", params: params)
      end
    end
  end
end
