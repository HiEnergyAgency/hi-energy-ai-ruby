# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

desc "Build the gem"
task :build do
  sh "gem build hi_energy_ai.gemspec"
end

task default: :spec
