require "spec_helper"

RSpec.describe Metrc do
  subject { Metrc::Config.new }

  let(:user_key) { "uuu-123" }
  let(:vendor_key) { "vvv-987" }
  let(:domain) { "https://api-xx.metrc.com" }
  let(:license_number) { 'ABC-X000X' }

  before do
    allow(ENV).to receive(:[]).with('METRC_USER_KEY').and_return(user_key)
    allow(ENV).to receive(:[]).with('METRC_VENDOR_KEY').and_return(vendor_key)
    allow(ENV).to receive(:[]).with('METRC_DOMAIN').and_return(domain)
    allow(ENV).to receive(:[]).with('METRC_LICENSE').and_return(license_number)
  end

  it "provides values from ENV" do
    expect(subject.domain).to eq domain
    expect(subject.license_number).to eq license_number
    expect(subject.user_key).to eq user_key
    expect(subject.vendor_key).to eq vendor_key
  end
end
