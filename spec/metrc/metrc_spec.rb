require "spec_helper"

RSpec.describe Metrc do
  subject { SubclassedMetrc.new(config, endpoint) }

  let(:config) do
    instance_double(Metrc::Config,
      domain: domain,
      license_number: license_number,
      user_key: user_key,
      vendor_key: vendor_key
    )
  end
  let(:user_key) { "uuu-123" }
  let(:vendor_key) { "vvv-987" }
  let(:domain) { "https://api-xx.metrc.com" }
  let(:license_number) { 'ABC-X000X' }

  let(:endpoint) { '/some/path' }
  let(:expected_response) { "{total: 'success'}" }

  class SubclassedMetrc < Metrc
    def initialize(config, endpoint)
      super(config)
      @endpoint = endpoint
    end

    def fetch
      get(@endpoint)
    end

    def fecth_with_params
      get(@endpoint, {one: 1, two: 2})
    end
  end

  it "exists" do
    expect(Metrc.new).to be_a(Metrc)
  end

  describe "get" do
    it "assembles http request correctly" do
      stub_request(:get, domain + endpoint)
        .with(
          query: {licenseNumber: license_number},
          basic_auth: [user_key, vendor_key],
          headers: {
            "Content-Type" => "application/json",
            "Accept" => "application/json"
          }
        )
        .to_return(body: expected_response)

      expect(subject.fetch.body).to eq expected_response
    end

    it "allows adding additional params" do
      stub_request(:get, domain + endpoint)
        .with(
          query: {
            licenseNumber: license_number,
            one: 1,
            two: 2
          },
        )
        .to_return(body: expected_response)

      expect(subject.fecth_with_params.body).to eq(expected_response)
    end
  end
end
