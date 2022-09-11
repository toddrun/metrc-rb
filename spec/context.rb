RSpec.shared_examples "simple get request" do |endpoint|
  let(:client) do
    instance_double(Metrc::Client, get: response_body)
  end
  let(:response_body) { "some response" }

  it "calls #{endpoint}" do
    expect(client).to receive(:get).with(endpoint)

    subject
  end

  it "returns the body of the response" do
    expect(subject).to eq response_body
  end
end
