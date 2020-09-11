# frozen_string_literal: true

describe Grape::ExtraValidators::MaximumValue do
  module ValidationsSpec
    module MaximumValueValidatorSpec
      class API < Grape::API
        default_format :json

        params do
          optional :static_number, type: Integer, maximum_value: 10
          optional :maximum_value_for_proc_number, type: Integer, allow_blank: false
          optional :proc_number, type: Integer, maximum_value: ->(params) { params[:maximum_value_for_proc_number] + 1 }
        end
        post "/" do
          body false
        end
      end
    end
  end

  def app
    ValidationsSpec::MaximumValueValidatorSpec::API
  end

  let(:params) do
    {
      static_number: static_number,
      maximum_value_for_proc_number: maximum_value_for_proc_number,
      proc_number: proc_number,
    }.compact
  end
  let(:static_number) { nil }
  let(:maximum_value_for_proc_number) { nil }
  let(:proc_number) { nil }
  before { post "/", params }
  subject { last_response.status }

  context "when a configured maximum value is a static value" do
    context "the value is less than the maximum value" do
      let(:static_number) { 9 }

      it { is_expected.to eq(204) }
    end

    context "the value is equal to the maximum value" do
      let(:static_number) { 10 }

      it { is_expected.to eq(204) }
    end

    context "the value is more than the maximum value" do
      let(:static_number) { 11 }

      it { is_expected.to eq(400) }
    end
  end

  context "when a configured maximum value is a Proc" do
    context "the value is less than the maximum value" do
      let(:maximum_value_for_proc_number) { 10 }
      let(:proc_number) { 10 }

      it { is_expected.to eq(204) }
    end

    context "the value is equal to the maximum value" do
      let(:maximum_value_for_proc_number) { 10 }
      let(:proc_number) { 11 }

      it { is_expected.to eq(204) }
    end

    context "the value is more than the maximum value" do
      let(:maximum_value_for_proc_number) { 10 }
      let(:proc_number) { 12 }

      it { is_expected.to eq(400) }
    end
  end

  context "when the parameter is nil" do
    let(:params) { {} }

    it { is_expected.to eq(204) }
  end
end
