# frozen_string_literal: true

require "spec_helper"

RSpec.describe HiEnergyApi::Paginator do
  let(:api_key) { "test_api_key" }
  let(:base_url) { "https://app.hienergy.ai/api/v1" }
  let(:client) { HiEnergyApi::Client.new(api_key: api_key, base_url: base_url) }

  it "iterates pages using meta.next_page" do
    stub_request(:get, "#{base_url}/deals")
      .with(query: { "limit" => "2" })
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: { data: [ { id: 1 } ], meta: { next_page: 2, has_more: true } }.to_json
      )

    stub_request(:get, "#{base_url}/deals")
      .with(query: { "limit" => "2", "page" => "2" })
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: { data: [ { id: 2 } ], meta: { next_page: nil, has_more: false } }.to_json
      )

    pages = client.paginate("/deals", params: { limit: 2 }).map(&:data)

    expect(pages).to eq([ [ { "id" => 1 } ], [ { "id" => 2 } ] ])
  end
end
