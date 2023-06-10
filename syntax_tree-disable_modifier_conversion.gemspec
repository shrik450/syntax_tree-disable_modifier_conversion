# frozen_string_literal: true

require_relative "lib/syntax_tree/disable_modifier_conversion/version"

Gem::Specification.new do |spec|
  spec.name = "syntax_tree-disable_modifier_conversion"
  spec.version = SyntaxTree::DisableModifierConversion::VERSION
  spec.authors = ["Shrikanth Upadhayaya"]
  spec.email = ["shrik450@gmail.com"]

  spec.summary = "Disable conversion of conditionals to modifier form when formatting with the syntax_tree gem."
  spec.homepage = "https://github.com/shrik450/syntax_tree-disable_modifier_conversion"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.require_paths = ["lib"]
end