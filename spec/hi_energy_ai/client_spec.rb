# frozen_string_literal: true

require "spec_helper"

RSpec.describe HiEnergyAi::Client do
  let(:api_key) { "test_api_key" }
  let(:base_url) { "https://app.hienergy.ai/api/v1" }
  let(:client) { described_class.new(api_key: api_key, base_url: base_url) }

  describe "#advertisers" do
    it "lists advertisers" do
      stub_request(:get, "#{base_url}/advertisers")
        .with(headers: { "X-Api-Key" => api_key }, query: hash_including("limit" => "5"))
        .to_return(
          status: 200,
          headers: { "Content-Type" => "application/json" },
          body: { data: [ { id: "1", type: "advertiser" } ], meta: { limit: 25 } }.to_json
        )

      response = client.advertisers.list(limit: 5)

      expect(response).to be_a(HiEnergyAi::Response)
      expect(response.data.length).to eq(1)
      expect(response.meta["limit"]).to eq(25)
    end

    it "fetches a single advertiser" do
      stub_request(:get, "#{base_url}/advertisers/42")
        .to_return(
          status: 200,
          headers: { "Content-Type" => "application/json" },
          body: { data: { id: "42", type: "advertiser" } }.to_json
        )

      response = client.advertisers.find(42)

      expect(response.data["id"]).to eq("42")
    end
  end

  describe "#deals" do
    it "lists deals with filters" do
      stub_request(:get, "#{base_url}/deals")
        .with(query: hash_including("active" => "true", "limit" => "10"))
        .to_return(
          status: 200,
          headers: { "Content-Type" => "application/json" },
          body: { data: [], meta: {} }.to_json
        )

      response = client.deals.list(active: true, limit: 10)

      expect(response).to be_success
    end
  end

  describe "#search" do
    it "runs universal search" do
      stub_request(:get, "#{base_url}/search")
        .with(query: hash_including("q" => "nike"))
        .to_return(
          status: 200,
          headers: { "Content-Type" => "application/json" },
          body: { advertisers: [], deals: [] }.to_json
        )

      response = client.search.query(q: "nike")

      expect(response).to be_success
    end
  end

  describe "error handling" do
    it "raises HiEnergyAi::Error with API error payload" do
      stub_request(:get, "#{base_url}/advertisers/999")
        .to_return(
          status: 404,
          headers: { "Content-Type" => "application/json" },
          body: {
            error: {
              code: "NOT_FOUND",
              message: "Resource not found",
              timestamp: "2026-05-18T00:00:00Z",
              request_id: "req_123"
            }
          }.to_json
        )

      expect { client.advertisers.find(999) }.to raise_error(HiEnergyAi::Error) do |error|
        expect(error.status).to eq(404)
        expect(error.code).to eq("NOT_FOUND")
        expect(error.request_id).to eq("req_123")
      end
    end
  end

  describe "initialization" do
    it "requires credentials" do
      expect { described_class.new }.to raise_error(ArgumentError, /api_key or bearer_token/)
    end

    it "accepts environment presets via splat" do
      preset = HiEnergyAi::Configuration::PRODUCTION
      c = described_class.new(api_key: api_key, **preset)
      expect(c.config.base_url).to eq(preset[:base_url])
      expect(c.config.app_origin).to eq(preset[:app_origin])
    end

    it "derives app_origin from a custom base_url when none is given" do
      c = described_class.new(api_key: api_key, base_url: "https://shard.example.com/api/v1")
      expect(c.config.app_origin).to eq("https://shard.example.com")
    end

    it "leaves the default app_origin alone when only credentials are supplied" do
      c = described_class.new(api_key: api_key)
      expect(c.config.app_origin).to eq(HiEnergyAi::Configuration::APP_ORIGIN)
    end
  end

  describe "dry_run" do
    it "appends dry_run=true when enabled on the client" do
      dry_client = described_class.new(api_key: api_key, base_url: base_url, dry_run: true)

      stub_request(:get, "#{base_url}/deals")
        .with(query: hash_including("dry_run" => "true"))
        .to_return(
          status: 200,
          headers: { "Content-Type" => "application/json" },
          body: { data: [] }.to_json
        )

      expect(dry_client.deals.list).to be_success
    end

    it "accepts the preferred `server_dry_run:` alias" do
      dry_client = described_class.new(api_key: api_key, base_url: base_url, server_dry_run: true)

      stub_request(:get, "#{base_url}/deals")
        .with(query: hash_including("dry_run" => "true"))
        .to_return(status: 200, headers: { "Content-Type" => "application/json" }, body: "{}")

      expect(dry_client.deals.list).to be_success
      expect(dry_client.config.server_dry_run).to be(true)
    end
  end

  describe "mutating resources" do
    let(:body_matcher) { ->(req) { JSON.parse(req.body) == { "contact" => { "email" => "x@y.com" } } } }

    it "accepts keyword-style attributes on create" do
      stub_request(:post, "#{base_url}/contacts")
        .with(&body_matcher)
        .to_return(status: 201, headers: { "Content-Type" => "application/json" }, body: { data: { id: "1" } }.to_json)

      expect(client.contacts.create(email: "x@y.com")).to be_success
    end

    it "still accepts a positional Hash on create (backwards compat)" do
      stub_request(:post, "#{base_url}/contacts")
        .with(&body_matcher)
        .with(query: hash_including("foo" => "bar"))
        .to_return(status: 201, headers: { "Content-Type" => "application/json" }, body: { data: { id: "1" } }.to_json)

      expect(client.contacts.create({ email: "x@y.com" }, foo: "bar")).to be_success
    end
  end

  describe "Tags resource" do
    it "no longer exposes #search (use #list)" do
      expect(client.tags).not_to respond_to(:search)
    end
  end
end
