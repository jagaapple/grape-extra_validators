# frozen_string_literal: true

describe Grape::ExtraValidators::Length do
  module ValidationsSpec
    module LengthValidatorSpec
      class API < Grape::API
        default_format :json

        resource :text do
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

        resource :array do
          params do
            optional :values, type: Array[Integer], length: 3
          end
          post "/integer" do
            body false
          end

          params do
            optional :values, type: Array[Integer], length: 2..4
          end
          post "/range" do
            body false
          end
        end
      end
    end
  end

  def app
    ValidationsSpec::LengthValidatorSpec::API
  end

  describe "String value validation" do
    let(:params) { { text: text } }
    let(:text) { nil }
    subject { last_response.status }

    describe "Specify an integer number" do
      before { post "/text/integer", params }

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
      before { |example| post "/text/range", params unless example.metadata[:skip_before_request_call] }

      context "when the length is less than the configured minimum length" do
        let(:text) { "123" }

        it { is_expected.to eq(400) }
      end

      context "when the length is within the configured length", skip_before_request_call: true do
        it "should pass" do
          post "/text/range", { text: "1234" }
          expect(last_response.status).to eq(204)

          post "/text/range", { text: "12345" }
          expect(last_response.status).to eq(204)

          post "/text/range", { text: "123456" }
          expect(last_response.status).to eq(204)

          post "/text/range", { text: "1234567" }
          expect(last_response.status).to eq(204)

          post "/text/range", { text: "12345678" }
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

  describe "Array value validation" do
    let(:params) { { values: values } }
    let(:values) { nil }
    subject { last_response.status }

    describe "Specify an integer number" do
      before { post "/array/integer", params }

      context "when the length is less than the configured length" do
        let(:values) { [1, 2] }
        it "fails with corresponding message" do
          is_expected.to eq(400)
          error = JSON.parse(last_response.body)["error"]
          expect(error).to eq("values must have exactly 3 items")
        end
      end

      context "when the length is equal to the configured length" do
        let(:values) { [1, 2, 3] }
        it { is_expected.to eq(204) }
      end

      context "when the length is more than the configured length" do
        let(:values) { [1, 2, 3, 4] }
        it "fails with corresponding message" do
          is_expected.to eq(400)
          error = JSON.parse(last_response.body)["error"]
          expect(error).to eq("values must have exactly 3 items")
        end
      end

      context "when the parameter is nil" do
        it { is_expected.to eq(204) }
      end
    end

    describe "Specify a range" do
      before { |example| post "/array/range", params unless example.metadata[:skip_before_request_call] }

      context "when the length is less than the configured minimum length" do
        let(:values) { [1] }
        it "fails with corresponding message" do
          is_expected.to eq(400)
          error = JSON.parse(last_response.body)["error"]
          expect(error).to eq("values must have 2 to 4 items")
        end
      end

      context "when the length is within the configured length", skip_before_request_call: true do
        it "should pass" do
          post "/array/range", { values: [1, 2] }
          expect(last_response.status).to eq(204)

          post "/array/range", { values: [1, 2, 3] }
          expect(last_response.status).to eq(204)

          post "/array/range", { values: [1, 2, 3, 4] }
          expect(last_response.status).to eq(204)
        end
      end

      context "when the length is more than the configured maximum length" do
        let(:values) { [1, 2, 3, 4, 5] }
        it "fails with corresponding message" do
          is_expected.to eq(400)
          error = JSON.parse(last_response.body)["error"]
          expect(error).to eq("values must have 2 to 4 items")
        end
      end

      context "when the parameter is nil" do
        it { is_expected.to eq(204) }
      end
    end
  end
end
