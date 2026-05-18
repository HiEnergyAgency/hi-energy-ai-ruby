# frozen_string_literal: true

module HiEnergyAi
  class Response
    attr_reader :status, :headers, :body, :data, :meta, :raw

    def initialize(status:, headers:, body:)
      @status = status
      @headers = headers
      @body = body
      @raw = body
      @data = body.is_a?(Hash) ? (body["data"] || body[:data]) : body
      @meta = body.is_a?(Hash) ? (body["meta"] || body[:meta]) : nil
    end

    def success?
      status >= 200 && status < 300
    end

    def [](key)
      return body[key] if body.is_a?(Hash)

      nil
    end

    def to_h
      body.is_a?(Hash) ? body : { "data" => body }
    end

    def pagination
      return meta if meta.is_a?(Hash) && meta.key?("pagination")

      body.is_a?(Hash) ? (body["pagination"] || body[:pagination]) : nil
    end

    def next_page
      return nil unless meta.is_a?(Hash)

      meta["next_page"] || meta[:next_page]
    end

    def has_more?
      return meta["has_more"] if meta.is_a?(Hash) && meta.key?("has_more")
      return meta[:has_more] if meta.is_a?(Hash) && meta.key?(:has_more)

      !next_page.nil?
    end

    def next_page_params
      page = next_page
      return nil if page.nil?

      { page: page }
    end
  end
end
