# Contributing to hi-energy-ai-ruby

Thank you for helping improve the official Ruby client for the [Hi Energy AI API](https://app.hienergy.ai/api_documentation).

## Reporting issues

Before opening an issue, check [existing issues](https://github.com/HiEnergyAgency/hi-energy-ai-ruby/issues) to avoid duplicates.

**Use issues for:**

- Bugs in the gem (wrong endpoints, params, parsing, errors, pagination)
- Missing API resources or methods that exist in the [API documentation](https://app.hienergy.ai/api_documentation)
- Documentation improvements
- Feature requests for the Ruby client

**Open an issue on GitHub:**

1. Go to [github.com/HiEnergyAgency/hi-energy-ai-ruby/issues](https://github.com/HiEnergyAgency/hi-energy-ai-ruby/issues)
2. Click **New issue**
3. Choose **Bug report** or **Feature request**
4. Fill in the template with as much detail as possible

**Please include (for bugs):**

- Ruby version (`ruby -v`)
- Gem version (`HiEnergyAi::VERSION` or your `Gemfile.lock`)
- Minimal code to reproduce the problem
- Expected vs actual behavior
- API response status/body if relevant (redact API keys)

**API platform issues** (auth, rate limits, data correctness on the server) may need to be reported through Hi Energy AI support rather than this repository.

## Submitting pull requests

We welcome pull requests that fix bugs, add API coverage, or improve docs/tests.

### Workflow

1. **Fork** [hi-energy-ai-ruby](https://github.com/HiEnergyAgency/hi-energy-ai-ruby) on GitHub
2. **Clone** your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/hi-energy-ai-ruby.git
   cd hi-energy-ai-ruby
   ```
3. **Create a branch** from `main`:
   ```bash
   git checkout -b your-short-description
   ```
4. **Install dependencies** and run tests:
   ```bash
   bundle install
   bundle exec rspec
   ```
5. **Make your changes** — match existing style and keep the diff focused
6. **Commit** with a clear message describing *why* the change is needed
7. **Push** to your fork:
   ```bash
   git push -u origin your-short-description
   ```
8. **Open a pull request** against `HiEnergyAgency/hi-energy-ai-ruby` → `main`:
   - Go to your fork on GitHub and click **Compare & pull request**, or
   - Visit [github.com/HiEnergyAgency/hi-energy-ai-ruby/compare](https://github.com/HiEnergyAgency/hi-energy-ai-ruby/compare)
9. Fill in the PR template (summary, test plan, linked issue if any)
10. Wait for review — maintainers may request changes before merge

### PR guidelines

- One logical change per PR when possible
- Add or update specs in `spec/` for behavior changes
- Do not commit API keys, `.env` files, or credentials
- Update `CHANGELOG.md` under **Unreleased** for user-visible changes
- Ensure `bundle exec rspec` passes before requesting review

### Development setup

```bash
git clone https://github.com/HiEnergyAgency/hi-energy-ai-ruby.git
cd hi-energy-ai-ruby
bundle install
bundle exec rspec
bin/console   # interactive client
```

## Code of conduct

Be respectful and constructive in issues and pull requests.

## Questions

- **API usage:** [app.hienergy.ai/api_documentation](https://app.hienergy.ai/api_documentation)
- **JavaScript SDK:** [hi-energy-ai-js](https://github.com/HiEnergyAgency/hi-energy-ai-js)
- **Gem on RubyGems:** [hi_energy_ai](https://rubygems.org/gems/hi_energy_ai)
