# frozen_string_literal: true

module HiEnergyAi
  class Resource
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
  end
end
