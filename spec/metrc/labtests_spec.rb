require "spec_helper"

RSpec.describe Metrc::Labtests do
  let(:response_body) { "some response" }
  let(:client) do
    instance_double(Metrc::Client, get: response_body)
  end

  describe "states" do
    subject { Metrc::Labtests.states(client) }

    it "gets states" do
      expect(client).to receive(:get).with('/labtests/v1/states')

      subject
    end

    it "returns the body of the response" do
      expect(subject).to eq response_body
    end
  end

  describe "types" do
    subject { Metrc::Labtests.types(client) }

    it "gets states" do
      expect(client).to receive(:get).with('/labtests/v1/types')

      subject
    end

    it "returns the body of the response" do
      expect(subject).to eq response_body
    end
  end
end
