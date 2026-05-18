# Changelog

## 0.1.0 — 2026-05-18

### Added

- Initial RubyGems release
- Faraday client for Hi Energy AI API v1 (`https://app.hienergy.ai/api/v1`)
- Resource accessors for advertisers, deals, contacts, transactions, clicks, reports, publishers, search, schema, tools, and more
- MCP helpers (`GET /mcp`, `POST /mcp` JSON-RPC, `GET /mcp/integration.json`)
- `HiEnergyApi::Error` with API error codes and `request_id`
- Offset pagination helpers on `HiEnergyApi::Response`
- Optional global `dry_run` query parameter support
