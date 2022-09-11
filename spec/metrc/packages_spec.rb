# frozen_string_literal: true

require "spec_helper"

RSpec.describe Metrc::Packages do
  let(:response_body) { "some response" }
  let(:client) do
    instance_double(Metrc::Client, get: response_body)
  end

  describe "types" do
    subject { Metrc::Packages.types(client) }

    it "gets types" do
      expect(client).to receive(:get).with('/packages/v1/types')

      subject
    end

    it "returns the body of the response" do
      expect(subject).to eq response_body
    end
  end
end
