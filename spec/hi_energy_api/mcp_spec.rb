# frozen_string_literal: true

require "spec_helper"

RSpec.describe HiEnergyApi::Resources::Mcp do
  let(:api_key) { "test_api_key" }
  let(:app_origin) { "https://app.hienergy.ai" }
  let(:client) { HiEnergyApi::Client.new(api_key: api_key, app_origin: app_origin) }

  it "fetches MCP bootstrap JSON" do
    stub_request(:get, "#{app_origin}/mcp")
      .with(headers: { "X-Api-Key" => api_key })
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: { protocolVersion: "2025-11-25" }.to_json
      )

    response = client.mcp.bootstrap

    expect(response).to be_success
    expect(response.body["protocolVersion"]).to eq("2025-11-25")
  end

  it "posts JSON-RPC initialize" do
    stub_request(:post, "#{app_origin}/mcp")
      .with(
        headers: { "X-Api-Key" => api_key },
        body: hash_including("method" => "initialize")
      )
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: { jsonrpc: "2.0", id: 1, result: {} }.to_json
      )

    response = client.mcp.initialize_session

    expect(response).to be_success
  end
end
