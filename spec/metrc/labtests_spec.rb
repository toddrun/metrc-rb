# frozen_string_literal: true

require "spec_helper"

RSpec.describe Metrc::Labtests do
  let(:response_body) { "some response" }
  let(:client) do
    instance_double(Metrc::Client, get: response_body)
  end

  describe "states" do
    subject { Metrc::Labtests.states(client: client) }

    it_behaves_like "a simple get request", "/labtests/v1/states"
  end

  describe "types" do
    subject { Metrc::Labtests.types(client: client) }

    it_behaves_like "a simple get request", "/labtests/v1/types"
  end
end
