# frozen_string_literal: true

require "json"
require "faraday"
require "faraday/net_http"

module HiEnergyAi
  class Client
    attr_reader :config

    def self.configure
      yield(configuration)
      configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def initialize(api_key: nil, bearer_token: nil, base_url: nil, app_origin: nil, timeout: nil, user_agent: nil, dry_run: nil)
      @config = self.class.configuration.dup
      @config.api_key = api_key if api_key
      @config.bearer_token = bearer_token if bearer_token
      @config.base_url = base_url if base_url
      @config.app_origin = app_origin if app_origin
      @config.timeout = timeout if timeout
      @config.user_agent = user_agent if user_agent
      @config.dry_run = dry_run unless dry_run.nil?

      unless @config.credentials_present?
        raise Error.new("api_key or bearer_token is required", code: "MISSING_CREDENTIALS")
      end
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

    def app_get(path, params: {})
      app_request(:get, path, params: params)
    end

    def app_post(path, params: {}, body: nil)
      app_request(:post, path, params: params, body: body)
    end

    def request(method, path, params: {}, body: nil)
      perform_request(api_connection, method, path, params: params, body: body)
    end

    def app_request(method, path, params: {}, body: nil)
      perform_request(app_connection, method, path, params: params, body: body)
    end

    def paginate(path, params: {})
      Paginator.new(client: self, path: path, params: params)
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

    def mcp
      @mcp ||= Resources::Mcp.new(self)
    end

    private

    def api_connection
      @api_connection ||= build_connection(config.base_url)
    end

    def app_connection
      @app_connection ||= build_connection(config.app_origin)
    end

    def build_connection(base_url)
      Faraday.new(url: base_url) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.options.timeout = config.timeout
        faraday.options.open_timeout = config.timeout
        faraday.headers["Accept"] = "application/json"
        faraday.headers["User-Agent"] = config.user_agent
        faraday.adapter Faraday.default_adapter
      end
    end

    def perform_request(connection, method, path, params: {}, body: nil)
      response = connection.run_request(method, normalize_path(path), body, nil) do |req|
        req.params.update(compact_params(params)) if params.any? || config.dry_run
        apply_auth!(req)
      end

      handle_response(response)
    rescue Faraday::ParsingError => e
      status, raw_body = extract_parsing_error_context(e)
      message = status ? "API request failed with status #{status}" : "Failed to parse API response"
      raise Error.new(message, status: status, code: "INVALID_RESPONSE_BODY", response_body: raw_body)
    end

    def extract_parsing_error_context(error)
      env = error.response
      case env
      when Hash
        [env[:status], env[:body]]
      when Faraday::Response
        [env.status, env.body]
      else
        [nil, nil]
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
      merged = params.each_with_object({}) do |(key, value), memo|
        next if value.nil?

        memo[key] = value
      end

      merged[:dry_run] = true if config.dry_run && !merged.key?(:dry_run) && !merged.key?("dry_run")
      merged
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
