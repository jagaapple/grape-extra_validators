# frozen_string_literal: true

describe Grape::ExtraValidators::Length do
  module ValidationsSpec
    module LengthValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :text, type: String, length: 6
        end
        post "/integer" do
          body false
        end

        params do
          optional :text, type: String, length: 4..8
        end
        post "/range" do
          body false
        end
      end
    end
  end

  def app
    ValidationsSpec::LengthValidatorSpec::API
  end

  let(:params) { { text: text } }
  let(:text) { nil }
  subject { last_response.status }

  describe "Specify an integer number" do
    before { post "/integer", params }

    context "when the length is less than the configured length" do
      let(:text) { "12345" }

      it { is_expected.to eq(400) }
    end

    context "when the length is equal to the configured length" do
      let(:text) { "123456" }

      it { is_expected.to eq(204) }
    end

    context "when the length is more than the configured length" do
      let(:text) { "1234567" }

      it { is_expected.to eq(400) }
    end

    context "when the parameter is nil" do
      it { is_expected.to eq(204) }
    end
  end

  describe "Specify a range" do
    before { |example| post "/range", params unless example.metadata[:skip_before_request_call] }

    context "when the length is less than the configured minimum length" do
      let(:text) { "123" }

      it { is_expected.to eq(400) }
    end

    context "when the length is within the configured length", skip_before_request_call: true do
      it "should pass" do
        post "/range", { text: "1234" }
        expect(last_response.status).to eq(204)

        post "/range", { text: "12345" }
        expect(last_response.status).to eq(204)

        post "/range", { text: "123456" }
        expect(last_response.status).to eq(204)

        post "/range", { text: "1234567" }
        expect(last_response.status).to eq(204)

        post "/range", { text: "12345678" }
        expect(last_response.status).to eq(204)
      end
    end

    context "when the length is more than the configured maximum length" do
      let(:text) { "123456789" }

      it { is_expected.to eq(400) }
    end

    context "when the parameter is nil" do
      it { is_expected.to eq(204) }
    end
  end
end
