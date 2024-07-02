# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

require "rake/extensiontask"

desc "Compile the Rust source code for the Blake3ruby extension"
task build: :compile

Rake::ExtensionTask.new("blake3ruby") do |ext|
  ext.lib_dir = "lib/blake3ruby"
end

task default: %i[compile spec rubocop]
