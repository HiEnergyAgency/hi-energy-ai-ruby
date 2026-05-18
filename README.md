# hi_energy_ai

Official Ruby client for the **[Hi Energy AI API](https://app.hienergy.ai/api_documentation)**.

The API aggregates affiliate data from FlexOffers, CJ, Rakuten, Impact, Awin, Partnerize, Pepperjam, ShareASale, and more. This gem wraps **API v1** at `https://app.hienergy.ai/api/v1` and documents every endpoint from the [API documentation](https://app.hienergy.ai/api_documentation).

## Installation

```ruby
gem "hi_energy_ai"
```

```bash
gem install hi_energy_ai
```

## Quick start

Get an API key from [API Documentation → API Key](https://app.hienergy.ai/api_documentation/api_key) (sign-in required).

```ruby
require "hi_energy_ai"

client = HiEnergyAi.new(api_key: ENV["HI_ENERGY_API_KEY"])

client.advertisers.list(limit: 5)
client.deals.list(active: true, country: "US")
client.search.query(q: "nike", types: "advertisers,deals", per_type_limit: 5)
client.reports.find("top_advertisers_by_sales", period: "last_90_days", limit: 10)
```

## Authentication

Preferred for integrations and agents:

```http
X-Api-Key: YOUR_API_KEY
```

```ruby
client = HiEnergyAi.new(api_key: "your_integration_key")
```

OAuth bearer tokens (signed-in user flows):

```ruby
client = HiEnergyAi.new(bearer_token: ENV["AUTH0_ACCESS_TOKEN"])
```

Legacy `api_key` query parameters are supported by the API but not used by this client.

## Configuration

```ruby
HiEnergyAi.configure do |config|
  config.api_key = ENV["HI_ENERGY_API_KEY"]
  config.base_url = HiEnergyAi::Configuration::API_BASE_URL
  config.app_origin = HiEnergyAi::Configuration::APP_ORIGIN
  config.timeout = 60
  config.dry_run = false
end

client = HiEnergyAi.new
```

| Setting | Default | Description |
|---------|---------|-------------|
| `base_url` | `https://app.hienergy.ai/api/v1` | REST API v1 base URL |
| `app_origin` | `https://app.hienergy.ai` | App origin for `/mcp` routes |
| `api_key` | — | `X-Api-Key` header value |
| `bearer_token` | — | `Authorization: Bearer` value |
| `dry_run` | `false` | Append `dry_run=true` to requests when enabled |
| `timeout` | `30` | Request timeout in seconds |

Local development:

```ruby
client = HiEnergyAi.new(
  api_key: ENV["HI_ENERGY_API_KEY"],
  base_url: "http://localhost:3000/api/v1",
  app_origin: "http://localhost:3000"
)
```

## API resources

Aligned with the [API playground](https://app.hienergy.ai/api_documentation):

| Client | HTTP | Notes |
|--------|------|-------|
| `search` | `GET /search` | Universal Searchkick omnibox |
| `deals` | `GET /deals`, `GET /deals/:id` | Offset pagination via `page`, `per_page`, `limit` |
| `advertisers` | `GET /advertisers`, `GET /advertisers/:id` | Filters, similar/related, contacts |
| `advertisers.search_by_domain` | `GET /advertisers/search_by_domain` | Domain lookup endpoint |
| `advertisers.by_domain` | `GET /advertisers?domain=` | Shorthand filter |
| `contacts` | `GET /contacts`, `POST /contacts` | Search and create |
| `transactions` | `GET /transactions`, `GET /transactions/:id` | Date and advertiser filters |
| `clicks` | `GET /clicks` | Requires `start_date` and `end_date` (≤90 days) |
| `opportunities` | `GET /opportunities` | Publisher opportunity advertisers |
| `verticals` | `GET /verticals` | Industry categories |
| `tags` | `GET /tags`, `GET /tags/:id/advertisers` | Searchkick tag search |
| `publishers` | CRUD + `find_linkedin_users` | Publisher and credential management |
| `agencies` | `GET /agencies`, `GET /agencies/:id` | |
| `networks` | `GET /networks`, `GET /networks/:id` | |
| `reports` | `GET /reports`, `GET /reports/:id` | Major aliases and materialized views |
| `users` | `GET/POST/PATCH /users` | Scoped user management |
| `status_changes` | `GET /status_changes` | Advertiser status history |
| `deeplinks` | `POST /deeplinks/generate` | Tracking link builder |
| `domains` | `GET /domains/search` | Domain search |
| `tools` | `GET /tools` | MCP tool catalog (JSON Schema) |
| `schema` | `GET /schema` | OpenAPI 3.0 document |
| `exports` | `GET/POST /exports` | Report exports |
| `mcp` | `GET/POST /mcp` | MCP bootstrap and JSON-RPC (app origin) |

### MCP

MCP routes live on the app origin, not under `/api/v1`:

```ruby
client.mcp.bootstrap
client.mcp.integration
client.mcp.initialize_session
client.mcp.call("tools/list")
```

### Pagination

List endpoints return `data` plus `meta` (`current_page`, `next_page`, `per_page`, `has_more`). Advertisers also support cursor mode when you pass `cursor` explicitly.

```ruby
response = client.deals.list(limit: 50)

client.paginate("/deals", params: { limit: 50 }).each do |page|
  page.data.each { |deal| puts deal }
end
```

### Dry run

Validate request wiring without consuming live data:

```ruby
client = HiEnergyAi.new(api_key: key, dry_run: true)
client.deals.list(active: true)
```

Or per request: `client.deals.list(active: true, dry_run: true)`.

## Responses and errors

Success responses are `HiEnergyAi::Response` objects:

```ruby
response = client.advertisers.list(limit: 5)
response.data
response.meta
response.status
```

Errors raise `HiEnergyAi::Error`:

```ruby
begin
  client.advertisers.find(999)
rescue HiEnergyAi::Error => e
  e.code
  e.message
  e.request_id
  e.status
end
```

## Rate limits

Per the API documentation:

- Hi Energy publisher accounts: **1,000 requests/hour**
- Other publishers: **10,000 requests/hour**

Rate limit headers: `X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`.

## Publishing to RubyGems

Maintainers with access:

```bash
gem build hi_energy_ai.gemspec
gem push hi_energy_ai-0.1.0.gem
```

RubyGems MFA is required (`rubygems_mfa_required` in the gemspec).

## Development

```bash
bundle install
bundle exec rspec
bundle exec rake
```

Console:

```bash
bin/console
```

## Links

- [API documentation](https://app.hienergy.ai/api_documentation)
- [OpenAPI reference](https://app.hienergy.ai/api_documentation/openapi)
- [Source code](https://github.com/HiEnergyAgency/hi_energy_ai)

## License

MIT — see [LICENSE.txt](LICENSE.txt). API access is subject to Hi Energy AI platform terms; an API key is required.
