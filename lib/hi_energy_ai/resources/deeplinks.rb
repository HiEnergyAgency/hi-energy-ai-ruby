# frozen_string_literal: true

module HiEnergyAi
  module Resources
    class Deeplinks < Resource
      def generate(attributes, **params)
        post("/deeplinks/generate", params: params, body: attributes)
      end
    end
  end
end
