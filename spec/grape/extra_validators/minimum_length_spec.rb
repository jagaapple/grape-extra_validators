# frozen_string_literal: true

describe Grape::ExtraValidators::MinimumLength do
  module ValidationsSpec
    module MinimumLengthValidatorSpec
      class API < Grape::API
        default_format :json

        resource :text do
          params do
            optional :text, type: String, minimum_length: 4
          end
          post do
            body false
          end
        end

        resource :array do
          params do
            optional :values, type: Array[Integer], minimum_length: 3
          end
          post do
            body false
          end
        end

        resource :integer do
          params do
            optional :value, type: Integer, minimum_length: 3
          end
          post do
            body false
          end
        end
      end
    end
  end

  def app
    ValidationsSpec::MinimumLengthValidatorSpec::API
  end

  describe "String value validation" do
    let(:params) { { text: text } }
    let(:text) { nil }
    before { post "/text", params }
    subject { last_response.status }

    context "when the length is less than the configured minimum length" do
      let(:text) { "123" }

      it "fails with corresponding message" do
        is_expected.to eq(400)
        error = JSON.parse(last_response.body)["error"]
        expect(error).to eq("text must be at least 4 characters long")
      end
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

  describe "Array value validation" do
    let(:params) { { values: values } }
    let(:values) { nil }
    before { post "/array", params }
    subject { last_response.status }

    context "when the length is less than the configured minimum length" do
      let(:values) { [1, 2] }

      it "fails with corresponding message" do
        is_expected.to eq(400)
        error = JSON.parse(last_response.body)["error"]
        expect(error).to eq("values must have at least 3 items")
      end
    end

    context "when the length is equal to the configured minimum length" do
      let(:values) { [1, 2, 3] }

      it { is_expected.to eq(204) }
    end

    context "when the length is more than the configured minimum length" do
      let(:values) { [1, 2, 3, 4] }

      it { is_expected.to eq(204) }
    end

    context "when the parameter is nil" do
      it { is_expected.to eq(204) }
    end
  end

  context "when used for a param of wrong type" do
    let(:params) { { value: 10 } }
    before { post "/integer", params }
    subject { last_response.status }
    it "fails with corresponding message" do
      is_expected.to eq(400)
      error = JSON.parse(last_response.body)["error"]
      expect(error).to eq("value minimum length cannot be validated (wrong parameter type: Integer)")
    end
  end

end
