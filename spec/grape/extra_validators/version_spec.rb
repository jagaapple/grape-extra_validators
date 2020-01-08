# frozen_string_literal: true

describe Grape::ExtraValidators, type: :feature do
  example "The version number is 0.1.0" do
    expect(described_class::VERSION).to eq("0.1.0")
  end
end