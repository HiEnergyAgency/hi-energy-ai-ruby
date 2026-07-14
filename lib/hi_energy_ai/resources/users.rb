# frozen_string_literal: true

module HiEnergyAi
  module Resources
    class Users < Resource
      def list(**params)
        get("/users", params: params)
      end

      def find(id, **params)
        get("/users/#{id}", params: params)
      end

      def create(attributes = UNSET, **params)
        body_attrs, query = split_attributes(attributes, params)
        post("/users", params: query, body: { user: body_attrs })
      end

      def update(id, attributes = UNSET, **params)
        body_attrs, query = split_attributes(attributes, params)
        patch("/users/#{id}", params: query, body: { user: body_attrs })
      end

      def resend_invitation(id, **params)
        post("/users/#{id}/resend_invitation", params: params)
      end

      def rotate_api_key(id, **params)
        post("/users/#{id}/rotate_api_key", params: params)
      end
    end
  end
end
