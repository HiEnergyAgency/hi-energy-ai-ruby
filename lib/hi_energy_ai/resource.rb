# frozen_string_literal: true

module HiEnergyAi
  class Resource
    UNSET = Object.new.freeze

    def initialize(client)
      @client = client
    end

    private

    attr_reader :client

    def get(path, params: {})
      client.get(path, params: params)
    end

    def post(path, params: {}, body: nil)
      client.post(path, params: params, body: body)
    end

    def patch(path, params: {}, body: nil)
      client.patch(path, params: params, body: body)
    end

    def delete(path, params: {})
      client.delete(path, params: params)
    end

    def app_get(path, params: {})
      client.app_get(path, params: params)
    end

    def app_post(path, params: {}, body: nil)
      client.app_post(path, params: params, body: body)
    end

    # Used by mutating methods that accept either a positional Hash of
    # body attributes (legacy) or keyword arguments (idiomatic Ruby).
    # When a positional hash is given (including an explicit `nil`),
    # kwargs are treated as query-string params; when the positional
    # argument is omitted entirely, all kwargs become body attributes.
    # Reject calls that provide neither, so mutating requests do not
    # silently send an empty body.
    def split_attributes(attributes, params)
      if attributes.equal?(UNSET)
        raise ArgumentError, "attributes are required" if params.empty?

        [params, {}]
      else
        [attributes, params]
      end
    end
  end
end
