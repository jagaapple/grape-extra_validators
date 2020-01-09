# frozen_string_literal: true

describe Grape::ExtraValidators::MaximumLength do
  module ValidationsSpec
    module MaximumLengthValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :text, type: String, maximum_length: 8
        end
        post "/" do
          body false
        end
      end
    end
  end

  def app
    ValidationsSpec::MaximumLengthValidatorSpec::API
  end

  let(:params) { { text: text } }
  let(:text) { nil }
  before { post "/", params }
  subject { last_response.status }

  context "when the length is less than the configured maximum length" do
    let(:text) { "1234567" }

    it { is_expected.to eq(204) }
  end

  context "when the length is equal to the configured maximum length" do
    let(:text) { "12345678" }

    it { is_expected.to eq(204) }
  end

  context "when the length is more than the configured maximum length" do
    let(:text) { "123456789" }

    it { is_expected.to eq(400) }
  end

  context "when the parameter is nil" do
    it { is_expected.to eq(204) }
  end
end
