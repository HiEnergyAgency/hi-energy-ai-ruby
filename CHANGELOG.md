# Changelog

## Unreleased

### Added

- `HiEnergyAi.new(server_dry_run: true)` and
  `Configuration#server_dry_run` as the preferred name for the existing
  `dry_run` option. The old `dry_run:` keyword still works as an alias.
  Both only set `?dry_run=true` on the request — the server still
  receives the call and your key must be valid.
- Mutating resource methods (`create`, `update`, `generate`, `add`) now
  accept idiomatic kwargs in addition to the positional Hash:
  `client.contacts.create(email: "x@y.com")` works the same as
  `client.contacts.create({ email: "x@y.com" })`.
- `HiEnergyAi::Configuration::PRODUCTION` environment preset. Splat into
  `HiEnergyAi.new(api_key: k, **HiEnergyAi::Configuration::PRODUCTION)`
  for portable code that doesn't hard-code hostnames.
- README sections covering hosts, request body envelopes, and the
  `by_domain` vs `search_by_domain` advertiser lookups.

### Changed

- When `base_url:` is overridden without `app_origin:`, the SDK now
  derives `app_origin` from the base URL (stripping the API path)
  instead of leaving it pointed at the default host. This keeps MCP
  calls — which target `<app_origin>/mcp`, not `<base_url>/mcp` — on
  the same host as the rest of the client.

### Removed

- `HiEnergyAi::Resources::Tags#search` (was a silent alias for `#list`).
  Use `client.tags.list(...)` directly.

## 0.1.0 — 2026-05-18

### Added

- Initial RubyGems release
- Faraday client for Hi Energy AI API v1 (`https://app.hienergy.ai/api/v1`)
- Resource accessors for advertisers, deals, contacts, transactions, clicks, reports, publishers, search, schema, tools, and more
- MCP helpers (`GET /mcp`, `POST /mcp` JSON-RPC, `GET /mcp/integration.json`)
- `HiEnergyAi::Error` with API error codes and `request_id`
- Offset pagination helpers on `HiEnergyAi::Response`
- Optional global `dry_run` query parameter support
