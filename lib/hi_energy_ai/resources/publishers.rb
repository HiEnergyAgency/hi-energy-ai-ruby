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

      def create(attributes, **params)
        post("/publishers", params: params, body: { publisher: attributes })
      end

      def update(id, attributes, **params)
        patch("/publishers/#{id}", params: params, body: { publisher: attributes })
      end

      def find_linkedin_users(id, **params)
        post("/publishers/#{id}/find_linkedin_users", params: params)
      end
    end
  end
end
