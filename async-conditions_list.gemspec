# frozen_string_literal: true

require_relative "lib/async/conditions_list/version"

Gem::Specification.new do |spec|
  spec.name = "async-conditions_list"
  spec.version = Async::ConditionsList::VERSION
  spec.authors = ["HolyWalley"]
  spec.email = ["yakau@hey.com"]

  spec.summary = "An extension to Async gem that allows to create a list of condition, wait for it and receive an array of results"
  spec.homepage = "https://github.com/HolyWalley/async-conditions_list"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/HolyWalley/async-conditions_list"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "async", "~> 2.17"
end
