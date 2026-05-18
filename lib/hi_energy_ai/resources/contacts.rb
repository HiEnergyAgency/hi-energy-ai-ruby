# frozen_string_literal: true

module HiEnergyAi
  module Resources
    class Contacts < Resource
      def list(**params)
        get("/contacts", params: params)
      end

      def create(attributes, **params)
        post("/contacts", params: params, body: { contact: attributes })
      end

      def add(attributes, **params)
        post("/contacts/add", params: params, body: { contact: attributes })
      end
    end
  end
end
