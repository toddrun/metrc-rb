require "spec_helper"

RSpec.describe Metrc::Client do
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
  let(:response_body) { '{"total": "success"}' }
  let(:expected_response) { JSON.parse(response_body) }

  class SubclassedMetrc < Metrc::Client
    def initialize(config, endpoint)
      super(config)
      @endpoint = endpoint
    end

    def fetch
      get(@endpoint)
    end

    def fetch_with_params
      get(@endpoint, {one: 1, two: 2})
    end

    def create(payload)
      post(@endpoint, payload)
    end

    def update(payload)
      put(@endpoint, payload)
    end
  end

  it "exists" do
    expect(Metrc::Client.new).to be_a(Metrc::Client)
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
        .to_return(body: response_body)

      expect(subject.fetch).to eq(expected_response)
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
        .to_return(body: response_body)

      expect(subject.fetch_with_params).to eq(expected_response)
    end
  end

  describe "post" do
    let(:payload) { { some: 'data' } }
    let(:status) { 200 }

    it "assembles http request correctly" do
      stub_request(:post, domain + endpoint)
        .with(
          query: {licenseNumber: license_number},
          body: payload,
          basic_auth: [user_key, vendor_key],
          headers: {
            "Content-Type" => "application/json",
            "Accept" => "application/json"
          }
        )
        .to_return(status: status)

      expect(subject.create(payload)).to eq(status)
    end
  end

  describe "put" do
    let(:payload) { { some: 'data' } }
    let(:status) { 200 }

    it "assembles http request correctly" do
      stub_request(:put, domain + endpoint)
        .with(
          query: {licenseNumber: license_number},
          body: payload,
          basic_auth: [user_key, vendor_key],
          headers: {
            "Content-Type" => "application/json",
            "Accept" => "application/json"
          }
        )
        .to_return(status: status)

      expect(subject.update(payload)).to eq(status)
    end
  end
end
