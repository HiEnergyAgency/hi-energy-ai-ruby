# frozen_string_literal: true

module HiEnergyAi
  module Resources
    class Contacts < Resource
      def list(**params)
        get("/contacts", params: params)
      end

      def create(attributes = UNSET, **params)
        body_attrs, query = split_attributes(attributes, params)
        post("/contacts", params: query, body: { contact: body_attrs })
      end

      def add(attributes = UNSET, **params)
        body_attrs, query = split_attributes(attributes, params)
        post("/contacts/add", params: query, body: { contact: body_attrs })
      end
    end
  end
end
