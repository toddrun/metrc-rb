# frozen_string_literal: true

require "spec_helper"

RSpec.describe Metrc::Packages do
  let(:response_body) { "some response" }
  let(:client) do
    instance_double(Metrc::Client, get: response_body)
  end

  describe "types" do
    subject { Metrc::Packages.types(client) }

    it_behaves_like "simple get request", "/packages/v1/types"
  end
end
