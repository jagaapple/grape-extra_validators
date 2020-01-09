# frozen_string_literal: true

describe Grape::ExtraValidators::MinimumLength do
  module ValidationsSpec
    module MinimumLengthValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :text, type: String, minimum_length: 4
        end
        post "/" do
          body false
        end
      end
    end
  end

  def app
    ValidationsSpec::MinimumLengthValidatorSpec::API
  end

  let(:params) { { text: text } }
  let(:text) { nil }
  before { post "/", params }
  subject { last_response.status }

  context "when the length is less than the configured minimum length" do
    let(:text) { "123" }

    it { is_expected.to eq(400) }
  end

  context "when the length is equal to the configured minimum length" do
    let(:text) { "1234" }

    it { is_expected.to eq(204) }
  end

  context "when the length is more than the configured minimum length" do
    let(:text) { "12345" }

    it { is_expected.to eq(204) }
  end

  context "when the parameter is nil" do
    it { is_expected.to eq(204) }
  end
end
