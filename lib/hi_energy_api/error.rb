# frozen_string_literal: true

module HiEnergyApi
  class Error < StandardError
    attr_reader :status, :code, :request_id, :details, :response_body

    def initialize(message = nil, status: nil, code: nil, request_id: nil, details: nil, response_body: nil)
      super(message)
      @status = status
      @code = code
      @request_id = request_id
      @details = details
      @response_body = response_body
    end

    def self.from_response(status, body)
      payload = parse_json(body)
      error = payload.is_a?(Hash) ? payload["error"] || payload[:error] : nil

      if error.is_a?(Hash)
        new(
          error["message"] || error[:message] || "API request failed",
          status: status,
          code: error["code"] || error[:code],
          request_id: error["request_id"] || error[:request_id],
          details: error["details"] || error[:details],
          response_body: body
        )
      else
        new("API request failed with status #{status}", status: status, response_body: body)
      end
    end

    def self.parse_json(body)
      return body if body.is_a?(Hash) || body.is_a?(Array)
      return {} if body.nil? || body.to_s.strip.empty?

      JSON.parse(body)
    rescue JSON::ParserError
      {}
    end
    private_class_method :parse_json
  end
end
