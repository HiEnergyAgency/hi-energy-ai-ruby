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

### Changed

- `HiEnergyAi.new` now raises `HiEnergyAi::Error` (with `code: "MISSING_CREDENTIALS"`)
  instead of `ArgumentError` when neither `api_key` nor `bearer_token` is
  configured, so a single `rescue HiEnergyAi::Error` catches all SDK
  failures.
- Non-JSON error responses (e.g. an HTML 502 from an upstream proxy) are
  now wrapped as `HiEnergyAi::Error` with the HTTP status and
  `code: "INVALID_RESPONSE_BODY"` instead of bubbling up a raw
  `Faraday::ParsingError`.

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
