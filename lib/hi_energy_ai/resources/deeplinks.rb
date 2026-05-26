# frozen_string_literal: true

module HiEnergyAi
  module Resources
    class Deeplinks < Resource
      def generate(attributes = UNSET, **params)
        body_attrs, query = split_attributes(attributes, params)
        post("/deeplinks/generate", params: query, body: body_attrs)
      end
    end
  end
end
