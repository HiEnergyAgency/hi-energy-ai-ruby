# frozen_string_literal: true

module HiEnergyAi
  module Resources
    class Publishers < Resource
      def list(**params)
        get("/publishers", params: params)
      end

      def find(id, **params)
        get("/publishers/#{id}", params: params)
      end

      def create(attributes = nil, **params)
        body_attrs, query = split_attributes(attributes, params)
        post("/publishers", params: query, body: { publisher: body_attrs })
      end

      def update(id, attributes = nil, **params)
        body_attrs, query = split_attributes(attributes, params)
        patch("/publishers/#{id}", params: query, body: { publisher: body_attrs })
      end

      def find_linkedin_users(id, **params)
        post("/publishers/#{id}/find_linkedin_users", params: params)
      end
    end
  end
end
