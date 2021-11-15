# frozen_string_literal: true

describe Grape::ExtraValidators::MaximumLength do
  module ValidationsSpec
    module MaximumLengthValidatorSpec
      class API < Grape::API
        default_format :json

        resource :text do
          params do
            optional :text, type: String, maximum_length: 8
          end
          post do
            body false
          end
        end

        resource :array do
          params do
            optional :values, type: Array[Integer], maximum_length: 3
          end
          post do
            body false
          end
        end

        resource :integer do
          params do
            optional :value, type: Integer, maximum_length: 3
          end
          post do
            body false
          end
        end
      end
    end
  end

  def app
    ValidationsSpec::MaximumLengthValidatorSpec::API
  end

  describe "String value validation" do
    let(:params) { { text: text } }
    let(:text) { nil }
    before { post "/text", params }
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

      it "fails with corresponding message" do
        is_expected.to eq(400)
        error = JSON.parse(last_response.body)["error"]
        expect(error).to eq("text must be up to 8 characters long")
      end
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

    context "when the length is less than the configured maximum length" do
      let(:values) { [1, 2] }

      it { is_expected.to eq(204) }
    end

    context "when the length is equal to the configured maximum length" do
      let(:values) { [1, 2, 3] }

      it { is_expected.to eq(204) }
    end

    context "when the length is more than the configured maximum length" do
      let(:values) { [1, 2, 3, 4] }

      it "fails with corresponding message" do
        is_expected.to eq(400)
        error = JSON.parse(last_response.body)["error"]
        expect(error).to eq("values must have up to 3 items")
      end
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
      expect(error).to eq("value maximum length cannot be validated (wrong parameter type: Integer)")
    end
  end
end
