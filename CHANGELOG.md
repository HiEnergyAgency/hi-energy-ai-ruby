# Changelog

## 0.1.1 — 2026-07-14

### Changed

- Rewrote the README with a complete Ruby resource reference, response, pagination, configuration, and error-handling documentation aligned with the current client
- Documented per-client configuration overrides and low-level `get`/`post`/`patch`/`delete` helpers
- Updated repository metadata URLs

### Added

- `bin/publish` release workflow script

## 0.1.0 — 2026-05-18

### Added

- Initial RubyGems release
- Faraday client for Hi Energy AI API v1 (`https://app.hienergy.ai/api/v1`)
- Resource accessors for advertisers, deals, contacts, transactions, clicks, reports, publishers, search, schema, tools, and more
- MCP helpers (`GET /mcp`, `POST /mcp` JSON-RPC, `GET /mcp/integration.json`)
- `HiEnergyAi::Error` with API error codes and `request_id`
- Offset pagination helpers on `HiEnergyAi::Response`
- Optional global `dry_run` query parameter support
