# Hi Energy AI Ruby Gem — Official Affiliate Marketing API Client

[![Gem Version](https://img.shields.io/gem/v/hi_energy_ai)](https://rubygems.org/gems/hi_energy_ai)
[![Ruby](https://img.shields.io/badge/ruby-%3E%3D%203.2-red)](https://www.ruby-lang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE.txt)
[![API Docs](https://img.shields.io/badge/docs-app.hienergy.ai-api_documentation-0d6efd)](https://app.hienergy.ai/api_documentation)

**`hi_energy_ai`** is the official **Ruby client** for the [Hi Energy AI API](https://app.hienergy.ai/api_documentation) — a production REST API for **affiliate marketing data**, **coupon deals**, **advertiser discovery**, **commission transactions**, **click reporting**, and **publisher analytics**.

Use this gem to integrate Hi Energy AI into Ruby on Rails apps, background jobs, data pipelines, AI agents, and MCP-compatible tools without hand-rolling HTTP calls.

| | |
|---|---|
| **RubyGems** | [`hi_energy_ai`](https://rubygems.org/gems/hi_energy_ai) |
| **API base URL** | `https://app.hienergy.ai/api/v1` |
| **Documentation** | [app.hienergy.ai/api_documentation](https://app.hienergy.ai/api_documentation) |
| **OpenAPI** | [OpenAPI reference](https://app.hienergy.ai/api_documentation/openapi) |
| **Repository** | [github.com/HiEnergyAgency/hi_energy_api](https://github.com/HiEnergyAgency/hi_energy_api) |

---

## Table of contents

- [What is the Hi Energy AI API?](#what-is-the-hi-energy-ai-api)
- [Why use the hi_energy_ai gem?](#why-use-the-hi_energy_ai-gem)
- [Installation](#installation)
- [Quick start](#quick-start)
- [Authentication](#authentication)
- [API endpoints covered](#api-endpoints-covered)
- [Affiliate networks and data sources](#affiliate-networks-and-data-sources)
- [MCP and AI agent integration](#mcp-and-ai-agent-integration)
- [Pagination, dry run, and rate limits](#pagination-dry-run-and-rate-limits)
- [Configuration](#configuration)
- [Error handling](#error-handling)
- [Frequently asked questions](#frequently-asked-questions)
- [Development](#development)
- [License](#license)

---

## What is the Hi Energy AI API?

[Hi Energy AI](https://app.hienergy.ai) aggregates and normalizes affiliate program data from major networks — including **FlexOffers**, **Commission Junction (CJ)**, **Rakuten**, **Impact**, **Awin**, **Partnerize**, **Pepperjam**, and **ShareASale** — and exposes it through a single, **AI-friendly JSON API**.

The platform is built for:

- **Affiliate marketers** searching deals and advertisers by domain, category, or keyword
- **Publishers** tracking transactions, clicks, commissions, and status changes
- **Developers** building dashboards, ETL jobs, or internal tools on structured JSON
- **AI agents** using MCP, OpenAPI, and predictable pagination metadata

Full reference: **[Hi Energy AI API Documentation](https://app.hienergy.ai/api_documentation)**

---

## Why use the hi_energy_ai gem?

| Benefit | Description |
|---------|-------------|
| **Official client** | Matches the public API playground and OpenAPI schema |
| **Typed Ruby API** | Resource objects (`client.deals`, `client.advertisers`, …) instead of raw URLs |
| **Auth built in** | `X-Api-Key` and OAuth bearer support |
| **Pagination helpers** | Auto-follow `meta.next_page` on list endpoints |
| **MCP support** | Bootstrap and JSON-RPC against `/mcp` on the app origin |
| **Dry run mode** | Validate requests with `dry_run=true` without live data |
| **MIT licensed** | Free to use in commercial Ruby projects |

---

## Installation

Add to your `Gemfile`:

```ruby
gem "hi_energy_ai"
```

Or install from RubyGems:

```bash
gem install hi_energy_ai
```

**Requirements:** Ruby **3.2+**

---

## Quick start

1. Sign in at [Hi Energy AI](https://app.hienergy.ai) and create an API key on the [API Key page](https://app.hienergy.ai/api_documentation/api_key).
2. Install the gem and call the API:

```ruby
require "hi_energy_ai"

client = HiEnergyAi.new(api_key: ENV["HI_ENERGY_API_KEY"])

# Affiliate advertisers
client.advertisers.list(limit: 5)

# Coupon / promo deals
client.deals.list(active: true, country: "US")

# Universal search (advertisers, deals, contacts, …)
client.search.query(q: "nike", types: "advertisers,deals", per_type_limit: 5)

# Commission and sales reports
client.reports.find("top_advertisers_by_sales", period: "last_90_days", limit: 10)
```

**Equivalent curl** (same API the gem calls):

```bash
curl -H "X-Api-Key: YOUR_API_KEY" \
  "https://app.hienergy.ai/api/v1/advertisers?limit=5"
```

```bash
curl -H "X-Api-Key: YOUR_API_KEY" \
  "https://app.hienergy.ai/api/v1/deals?active=true&country=US"
```

---

## Authentication

The Hi Energy AI API accepts API keys via header (recommended):

```http
X-Api-Key: YOUR_API_KEY
```

```ruby
client = HiEnergyAi.new(api_key: "your_integration_key")
```

OAuth **Bearer** tokens for signed-in user sessions:

```ruby
client = HiEnergyAi.new(bearer_token: ENV["AUTH0_ACCESS_TOKEN"])
```

Get your key: [API Documentation → API Key](https://app.hienergy.ai/api_documentation/api_key)

---

## API endpoints covered

Every method maps to the [API playground](https://app.hienergy.ai/api_documentation):

| Ruby client | HTTP | Use case |
|-------------|------|----------|
| `search` | `GET /api/v1/search` | Universal Searchkick search |
| `deals` | `GET /api/v1/deals` | List and filter affiliate deals / coupons |
| `advertisers` | `GET /api/v1/advertisers` | Advertiser discovery and filters |
| `advertisers.search_by_domain` | `GET /api/v1/advertisers/search_by_domain` | Lookup by domain |
| `advertisers.by_domain` | `GET /api/v1/advertisers?domain=` | Domain filter shorthand |
| `contacts` | `GET`, `POST /api/v1/contacts` | Contact search and create |
| `transactions` | `GET /api/v1/transactions` | Affiliate sales and commissions |
| `clicks` | `GET /api/v1/clicks` | Click-level reporting (date range required) |
| `opportunities` | `GET /api/v1/opportunities` | Publisher opportunity advertisers |
| `verticals` | `GET /api/v1/verticals` | Industry / category list |
| `tags` | `GET /api/v1/tags` | Tag search and tagged advertisers |
| `publishers` | CRUD `/api/v1/publishers` | Publisher accounts and credentials |
| `agencies` | `GET /api/v1/agencies` | Agency directory |
| `networks` | `GET /api/v1/networks` | Affiliate network list |
| `reports` | `GET /api/v1/reports` | Prebuilt analytics reports |
| `users` | `/api/v1/users` | Scoped user management |
| `status_changes` | `GET /api/v1/status_changes` | Advertiser approval history |
| `deeplinks` | `POST /api/v1/deeplinks/generate` | Tracking link generator |
| `domains` | `GET /api/v1/domains/search` | Domain search |
| `tools` | `GET /api/v1/tools` | MCP tool catalog (JSON Schema) |
| `schema` | `GET /api/v1/schema` | OpenAPI 3.0 download |
| `exports` | `/api/v1/exports` | Async report exports |
| `mcp` | `GET`, `POST /mcp` | MCP bootstrap and JSON-RPC |

---

## Affiliate networks and data sources

Hi Energy AI normalizes feeds from:

FlexOffers · CJ (Commission Junction) · Rakuten Advertising · Impact · Awin · Partnerize · Pepperjam · ShareASale · proprietary enrichment

One API key, one JSON schema — no per-network SDK required in Ruby.

---

## MCP and AI agent integration

The API is designed for **AI agents**, **chatbots**, and **MCP clients**. MCP routes run on the app origin (`https://app.hienergy.ai`), not under `/api/v1`:

```ruby
client.mcp.bootstrap
client.mcp.integration
client.mcp.initialize_session
client.mcp.call("tools/list")
```

**Initialize MCP via curl:**

```bash
curl -X POST https://app.hienergy.ai/mcp \
  -H "X-Api-Key: YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-11-25"}}'
```

See also: [MCP Server documentation](https://app.hienergy.ai/api_documentation) · [OpenAPI reference](https://app.hienergy.ai/api_documentation/openapi)

---

## Pagination, dry run, and rate limits

### Pagination

List responses include `data` and `meta` (`current_page`, `next_page`, `per_page`, `has_more`):

```ruby
client.paginate("/deals", params: { limit: 50 }).each do |page|
  page.data.each { |deal| process(deal) }
end
```

### Dry run

Test integration wiring without live data:

```ruby
HiEnergyAi.new(api_key: key, dry_run: true).deals.list(active: true)
```

### Rate limits

| Account type | Limit |
|--------------|-------|
| Hi Energy publisher | 1,000 requests / hour |
| Other publishers | 10,000 requests / hour |

Headers: `X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`

---

## Configuration

```ruby
HiEnergyAi.configure do |config|
  config.api_key = ENV["HI_ENERGY_API_KEY"]
  config.base_url = HiEnergyAi::Configuration::API_BASE_URL   # https://app.hienergy.ai/api/v1
  config.app_origin = HiEnergyAi::Configuration::APP_ORIGIN   # https://app.hienergy.ai
  config.timeout = 60
end

client = HiEnergyAi.new
```

| Setting | Default |
|---------|---------|
| `base_url` | `https://app.hienergy.ai/api/v1` |
| `app_origin` | `https://app.hienergy.ai` |
| `timeout` | `30` seconds |

---

## Error handling

```ruby
begin
  client.advertisers.find(999)
rescue HiEnergyAi::Error => e
  e.code          # API error code
  e.message       # Human-readable message
  e.request_id    # Support / debugging
  e.status        # HTTP status
end
```

---

## Frequently asked questions

### What is the difference between hi_energy_ai and calling the REST API directly?

The gem wraps the same endpoints documented at [app.hienergy.ai/api_documentation](https://app.hienergy.ai/api_documentation). It adds Ruby resource methods, authentication headers, JSON parsing, pagination iterators, and structured errors — so you do not maintain Faraday or Net::HTTP code in every project.

### Is there a Python or JavaScript SDK?

This repository is the **official Ruby gem**. Other languages can use the REST API or OpenAPI spec at `GET /api/v1/schema`.

### How do I search advertisers by website domain?

```ruby
client.advertisers.by_domain("amazon.com")
# or
client.advertisers.search_by_domain(domain: "amazon.com")
```

### Does the gem support OpenClaw or custom AI tools?

Yes. Use `client.tools.list` for the MCP tool catalog, `client.schema.fetch` for OpenAPI, and `client.mcp` for JSON-RPC against `/mcp`.

### Where do I get an API key?

Sign in at [app.hienergy.ai](https://app.hienergy.ai) and visit [API Documentation → API Key](https://app.hienergy.ai/api_documentation/api_key).

---

## Development

```bash
git clone https://github.com/HiEnergyAgency/hi_energy_api.git
cd hi_energy_api
bundle install
bundle exec rspec
```

Interactive console:

```bash
bin/console
```

---

## Related links

- [Hi Energy AI API Documentation](https://app.hienergy.ai/api_documentation) — full endpoint reference and playground
- [OpenAPI / Swagger](https://app.hienergy.ai/api_documentation/openapi)
- [RubyGems: hi_energy_ai](https://rubygems.org/gems/hi_energy_ai)
- [GitHub: HiEnergyAgency/hi_energy_api](https://github.com/HiEnergyAgency/hi_energy_api)
- [CHANGELOG](CHANGELOG.md)

---

## License

MIT — see [LICENSE.txt](LICENSE.txt).

API access requires a Hi Energy AI account and API key. Platform terms apply at [app.hienergy.ai](https://app.hienergy.ai).
