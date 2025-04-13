# frozen_string_literal: true

require_relative "lib/blake3ruby/version"

Gem::Specification.new do |spec|
  spec.name = "blake3ruby"
  spec.version = Blake3ruby::VERSION
  spec.authors = ["Nightforge"]
  spec.email = ["modo00@gmail.com"]

  spec.summary = "Ruby bindings for the blake3 hash function"
  spec.description = "Ruby bindings for the blake3 hash function using the Rust implementation"
  spec.homepage = "https://github.com/Nightforge/blake3ruby"
  spec.required_ruby_version = ">= 3.1"
  spec.required_rubygems_version = ">= 3.3.11"
  spec.licenses = %w[MIT Ruby]

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Nightforge/blake3ruby"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.files << %w[Cargo.lock LICENSE.txt README.md]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions = ["ext/blake3ruby/Cargo.toml"]
end
