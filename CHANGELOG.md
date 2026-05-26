# Changelog

## Unreleased

### Changed

- `HiEnergyAi.new` now raises `HiEnergyAi::Error` (with `code: "MISSING_CREDENTIALS"`)
  instead of `ArgumentError` when neither `api_key` nor `bearer_token` is
  configured, so a single `rescue HiEnergyAi::Error` catches all SDK
  failures.
- Non-JSON error responses (e.g. an HTML 502 from an upstream proxy) are
  now wrapped as `HiEnergyAi::Error` with the HTTP status and
  `code: "INVALID_RESPONSE_BODY"` instead of bubbling up a raw
  `Faraday::ParsingError`.

## 0.1.0 — 2026-05-18

### Added

- Initial RubyGems release
- Faraday client for Hi Energy AI API v1 (`https://app.hienergy.ai/api/v1`)
- Resource accessors for advertisers, deals, contacts, transactions, clicks, reports, publishers, search, schema, tools, and more
- MCP helpers (`GET /mcp`, `POST /mcp` JSON-RPC, `GET /mcp/integration.json`)
- `HiEnergyAi::Error` with API error codes and `request_id`
- Offset pagination helpers on `HiEnergyAi::Response`
- Optional global `dry_run` query parameter support
