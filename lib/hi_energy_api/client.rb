# frozen_string_literal: true

require "json"
require "faraday"
require "faraday/net_http"

module HiEnergyApi
  class Client
    attr_reader :config

    def self.configure
      yield(configuration)
      configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def initialize(api_key: nil, bearer_token: nil, base_url: nil, timeout: nil, user_agent: nil)
      @config = self.class.configuration.dup
      @config.api_key = api_key if api_key
      @config.bearer_token = bearer_token if bearer_token
      @config.base_url = base_url if base_url
      @config.timeout = timeout if timeout
      @config.user_agent = user_agent if user_agent

      raise ArgumentError, "api_key or bearer_token is required" unless @config.credentials_present?
    end

    def get(path, params: {})
      request(:get, path, params: params)
    end

    def post(path, params: {}, body: nil)
      request(:post, path, params: params, body: body)
    end

    def patch(path, params: {}, body: nil)
      request(:patch, path, params: params, body: body)
    end

    def delete(path, params: {})
      request(:delete, path, params: params)
    end

    def request(method, path, params: {}, body: nil)
      response = connection.run_request(method, normalize_path(path), body, nil) do |req|
        req.params.update(compact_params(params)) if params.any?
        apply_auth!(req)
      end

      handle_response(response)
    end

    def tools
      @tools ||= Resources::Tools.new(self)
    end

    def schema
      @schema ||= Resources::Schema.new(self)
    end

    def search
      @search ||= Resources::Search.new(self)
    end

    def advertisers
      @advertisers ||= Resources::Advertisers.new(self)
    end

    def deals
      @deals ||= Resources::Deals.new(self)
    end

    def contacts
      @contacts ||= Resources::Contacts.new(self)
    end

    def transactions
      @transactions ||= Resources::Transactions.new(self)
    end

    def clicks
      @clicks ||= Resources::Clicks.new(self)
    end

    def opportunities
      @opportunities ||= Resources::Opportunities.new(self)
    end

    def reports
      @reports ||= Resources::Reports.new(self)
    end

    def publishers
      @publishers ||= Resources::Publishers.new(self)
    end

    def agencies
      @agencies ||= Resources::Agencies.new(self)
    end

    def networks
      @networks ||= Resources::Networks.new(self)
    end

    def status_changes
      @status_changes ||= Resources::StatusChanges.new(self)
    end

    def tags
      @tags ||= Resources::Tags.new(self)
    end

    def users
      @users ||= Resources::Users.new(self)
    end

    def verticals
      @verticals ||= Resources::Verticals.new(self)
    end

    def domains
      @domains ||= Resources::Domains.new(self)
    end

    def deeplinks
      @deeplinks ||= Resources::Deeplinks.new(self)
    end

    def exports
      @exports ||= Resources::Exports.new(self)
    end

    private

    def connection
      @connection ||= Faraday.new(url: config.base_url) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.options.timeout = config.timeout
        faraday.options.open_timeout = config.timeout
        faraday.headers["Accept"] = "application/json"
        faraday.headers["User-Agent"] = config.user_agent
        faraday.adapter Faraday.default_adapter
      end
    end

    def apply_auth!(req)
      if !config.api_key.to_s.empty?
        req.headers["X-Api-Key"] = config.api_key
      elsif !config.bearer_token.to_s.empty?
        req.headers["Authorization"] = "Bearer #{config.bearer_token}"
      end
    end

    def normalize_path(path)
      path.to_s.delete_prefix("/")
    end

    def compact_params(params)
      params.each_with_object({}) do |(key, value), memo|
        next if value.nil?

        memo[key] = value
      end
    end

    def handle_response(response)
      status = response.status
      body = normalize_body(response.body)

      return Response.new(status: status, headers: response.headers, body: body) if success_status?(status)

      raise Error.from_response(status, body)
    end

    def normalize_body(body)
      return body if body.is_a?(Hash) || body.is_a?(Array)
      return {} if body.nil? || body.to_s.strip.empty?

      JSON.parse(body)
    rescue JSON::ParserError
      body
    end

    def success_status?(status)
      status >= 200 && status < 300
    end
  end
end
