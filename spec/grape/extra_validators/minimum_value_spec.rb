# frozen_string_literal: true

describe Grape::ExtraValidators::MinimumValue do
  module ValidationsSpec
    module MinimumValueValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :static_number, type: Integer, minimum_value: 10
          optional :minimum_value_for_proc_number, type: Integer, allow_blank: false
          optional :proc_number, type: Integer, minimum_value: ->(params) { params[:minimum_value_for_proc_number] - 1 }
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

  let(:params) do
    {
      static_number: static_number,
      minimum_value_for_proc_number: minimum_value_for_proc_number,
      proc_number: proc_number,
    }.compact
  end
  let(:static_number) { nil }
  let(:minimum_value_for_proc_number) { nil }
  let(:proc_number) { nil }
  before { post "/", params }
  subject { last_response.status }

  context "when a configured minimum value is a static value" do
    context "when the value is less than the minimum value" do
      let(:static_number) { 9 }

      it { is_expected.to eq(400) }
    end

    context "when the value is equal to the minimum value" do
      let(:static_number) { 10 }

      it { is_expected.to eq(204) }
    end

    context "when the value is more than the minimum value" do
      let(:static_number) { 11 }

      it { is_expected.to eq(204) }
    end
  end

  context "when a configured minimum value is a Proc" do
    context "the value is less than the minimum value" do
      let(:minimum_value_for_proc_number) { 12 }
      let(:proc_number) { 10 }

      it { is_expected.to eq(400) }
    end

    context "the value is equal to the minimum value" do
      let(:minimum_value_for_proc_number) { 12 }
      let(:proc_number) { 11 }

      it { is_expected.to eq(204) }
    end

    context "the value is more than the minimum value" do
      let(:minimum_value_for_proc_number) { 12 }
      let(:proc_number) { 12 }

      it { is_expected.to eq(204) }
    end
  end

  context "when the parameter is nil" do
    let(:params) { {} }

    it { is_expected.to eq(204) }
  end
end
