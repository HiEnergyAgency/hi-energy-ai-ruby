# Hi Energy API

Ruby client for the [Hi Energy AI](https://app.hienergy.ai) REST API (`/api/v1`).

Authenticate with your integration API key (`X-Api-Key` header) or an OAuth bearer token. API keys are managed in the Hi Energy app under **API Documentation → API Key**.

## Installation

```ruby
gem "hi_energy_api", github: "HiEnergyAgency/hi_energy_api"
```

Or after publishing to RubyGems:

```ruby
gem "hi_energy_api"
```

## Quick start

```ruby
require "hi_energy_api"

client = HiEnergyApi.new(api_key: ENV["HI_ENERGY_API_KEY"])

client.tools.list
client.schema.fetch
client.search.query(q: "nike", types: "advertisers,deals", per_type_limit: 5)

advertisers = client.advertisers.list(limit: 10)
advertiser = client.advertisers.find(123)

deals = client.deals.list(active: true, country: "US", limit: 25)
deal = client.deals.find(456)

contacts = client.contacts.list(q: "acme", limit: 5)
report = client.reports.find("top_advertisers_by_sales", period: "last_90_days", limit: 10)

publisher = client.publishers.find(16)
```

## Configuration

```ruby
HiEnergyApi.configure do |config|
  config.api_key = ENV["HI_ENERGY_API_KEY"]
  config.base_url = "http://localhost:3000/api/v1"
  config.timeout = 60
end

client = HiEnergyApi.new
```

Per-client overrides:

```ruby
client = HiEnergyApi.new(
  api_key: "your_key",
  base_url: "https://app.hienergy.ai/api/v1",
  timeout: 30
)
```

OAuth bearer token (signed-in user flows):

```ruby
client = HiEnergyApi.new(bearer_token: ENV["AUTH0_ACCESS_TOKEN"])
```

## Resources

| Accessor | Endpoints |
|----------|-----------|
| `tools` | `GET /tools` |
| `schema` | `GET /schema` |
| `search` | `GET /search` |
| `advertisers` | list, find, search_by_domain, contacts, similar, related |
| `deals` | list, find, types, translate |
| `contacts` | list, create, add |
| `transactions` | list, find |
| `clicks` | list (requires `start_date`, `end_date`) |
| `opportunities` | list |
| `reports` | list, find |
| `publishers` | list, find, create, update |
| `agencies` | list, find |
| `networks` | list, find |
| `status_changes` | list |
| `tags` | list, advertisers |
| `users` | list, find, create, update, resend_invitation, rotate_api_key |
| `verticals` | list |
| `domains` | search |
| `deeplinks` | generate |
| `exports` | list, find, create |

Low-level HTTP access:

```ruby
client.get("/advertisers", params: { limit: 5 })
client.post("/deeplinks/generate", body: { url: "https://example.com/product" })
```

## Responses and errors

Successful calls return `HiEnergyApi::Response` with `#data`, `#meta`, `#status`, and `#to_h`.

Failed calls raise `HiEnergyApi::Error` with `#status`, `#code`, `#message`, and `#request_id` from the API error envelope.

```ruby
begin
  client.advertisers.find(999)
rescue HiEnergyApi::Error => e
  puts e.code
  puts e.request_id
end
```

## Development

```bash
bundle install
bundle exec rspec
```

## License

Proprietary — Hi Energy Agency. Contact patrick@hienergy.ai for licensing.
