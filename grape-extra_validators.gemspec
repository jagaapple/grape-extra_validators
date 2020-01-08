# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)
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
  spec.required_ruby_version = ">= 2.4.0"
  spec.files                 = Dir["**/*"].keep_if { |file| File.file?(file) }
  spec.test_files            = Dir["spec/**/*"]
  spec.require_paths         = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
end
