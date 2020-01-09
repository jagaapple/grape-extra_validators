# frozen_string_literal: true

describe Grape::ExtraValidators::StartWith do
  module ValidationsSpec
    module StartWithValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :text, type: String, start_with: "https://"
        end
        post "/not-array" do
          body false
        end

        params do
          optional :text, type: String, start_with: ["http://", "https://"]
        end
        post "/array" do
          body false
        end
      end
    end
  end

  def app
    ValidationsSpec::StartWithValidatorSpec::API
  end

  let(:params) { { text: text } }
  let(:text) { nil }
  subject { last_response.status }

  describe "Specify a not array" do
    before { post "/not-array", params }

    context "when the string starts with the specific string" do
      let(:text) { "https://example.com" }

      it { is_expected.to eq(204) }
    end

    context "when the string does not start with the specific string" do
      let(:text) { "http://example.com" }

      it { is_expected.to eq(400) }
    end

    context "when the parameter is nil" do
      it { is_expected.to eq(204) }
    end
  end

  describe "Specify an array" do
    before { |example| post "/array", params unless example.metadata[:skip_before_request_call] }

    context "when the string starts with a string one of the specific strings" do
      it "should not return any errors", skip_before_request_call: true do
        ["http://example.com", "https://example.com"].each do |text|
          post "/array", { text: text }
          expect(last_response.status).to eq(204)
        end
      end
    end

    context "when the string does not start with a string one of the specific strings" do
      let(:text) { "file://example.com" }

      it { is_expected.to eq(400) }
    end
  end
end
