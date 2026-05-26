# frozen_string_literal: true

module HiEnergyAi
  module Resources
    class Exports < Resource
      def list(**params)
        get("/exports", params: params)
      end

      def find(id, **params)
        get("/exports/#{id}", params: params)
      end

      def create(attributes = UNSET, **params)
        body_attrs, query = split_attributes(attributes, params)
        post("/exports", params: query, body: body_attrs)
      end
    end
  end
end
