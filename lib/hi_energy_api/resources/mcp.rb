# frozen_string_literal: true

module HiEnergyApi
  module Resources
    class Mcp < Resource
      def bootstrap(**params)
        app_get("mcp", params: params)
      end

      def integration(**params)
        app_get("mcp/integration.json", params: params)
      end

      def initialize_session(protocol_version: "2025-11-25", id: 1, **params)
        app_post(
          "mcp",
          params: params,
          body: {
            jsonrpc: "2.0",
            id: id,
            method: "initialize",
            params: { protocolVersion: protocol_version }
          }
        )
      end

      def call(method, params: {}, id: 1, **query)
        app_post(
          "mcp",
          params: query,
          body: {
            jsonrpc: "2.0",
            id: id,
            method: method,
            params: params
          }
        )
      end
    end
  end
end
