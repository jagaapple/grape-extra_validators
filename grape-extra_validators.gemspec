# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "grape/extra_validators/version"

Gem::Specification.new do |spec|
  spec.name                  = "grape-extra_validators"
  spec.version               = Grape::ExtraValidators::VERSION
  spec.authors               = ["Jaga Apple"]
  spec.email                 = ["jagaapple@uniboar.com"]

  spec.summary               = "Extra validators for Grape."
  spec.description           = "Extra validators for a Ruby Web API framework Grape."
  spec.homepage              = "https://github.com/jagaapple/grape-extra_validators"
  spec.license               = "MIT"

  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = ">= 2.5.0"
  spec.files                 = Dir["**/*"].keep_if { |file| File.file?(file) }
  spec.test_files            = Dir["spec/**/*"]
  spec.require_paths         = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "grape", ">= 1.0.0"

  spec.add_development_dependency "bundler", "~> 1.17.2"
  spec.add_development_dependency "codecov", "~> 0.2.11"
  spec.add_development_dependency "rack-test", "~> 1.1.0"
  spec.add_development_dependency "rake", "~> 13.0.1"
  spec.add_development_dependency "rspec", "~> 3.9.0"
  spec.add_development_dependency "rubocop", "~> 0.90.0"
  spec.add_development_dependency "simplecov", "~> 0.19.0"
  spec.add_development_dependency "simplecov-console", "~> 0.7.2"
end
