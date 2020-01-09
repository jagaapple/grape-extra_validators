# frozen_string_literal: true

describe Grape::ExtraValidators::MinimumValue do
  module ValidationsSpec
    module MinimumValueValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :number, type: Integer, minimum_value: 10
        end
        post "/" do
          body false
        end
      end
    end
  end

  def app
    ValidationsSpec::MinimumValueValidatorSpec::API
  end

  let(:params) { { number: number } }
  let(:number) { nil }
  before { post "/", params }
  subject { last_response.status }

  context "when the value is less than the configured minimum value" do
    let(:number) { 9 }

    it { is_expected.to eq(400) }
  end

  context "when the value is equal to the configured minimum value" do
    let(:number) { 10 }

    it { is_expected.to eq(204) }
  end

  context "when the value is more than the configured minimum value" do
    let(:number) { 11 }

    it { is_expected.to eq(204) }
  end

  context "when the parameter is nil" do
    it { is_expected.to eq(204) }
  end
end
