# frozen_string_literal: true

module HiEnergyAi
  module Resources
    class Advertisers < Resource
      def list(**params)
        get("/advertisers", params: params)
      end

      def find(id, **params)
        get("/advertisers/#{id}", params: params)
      end

      def search_by_domain(domain:, **params)
        get("/advertisers/search_by_domain", params: params.merge(domain: domain))
      end

      def by_domain(domain:, **params)
        list(domain: domain, **params)
      end

      def contacts(id, **params)
        get("/advertisers/#{id}/contacts", params: params)
      end

      def similar(id, **params)
        get("/advertisers/#{id}/similar_advertisers", params: params)
      end

      def related(id, **params)
        get("/advertisers/#{id}/related_advertisers", params: params)
      end

      def find_more_contacts(id, **params)
        post("/advertisers/#{id}/find_more_contacts", params: params)
      end
    end
  end
end
