RSpec.shared_context "with metrc client" do
  let(:client) do
    instance_double(Metrc::Client, get: response_body)
  end
  let(:response_body) { "some response" }
end

RSpec.shared_examples "a simple get request" do |endpoint|
  include_context "with metrc client"

  it "calls #{endpoint}" do
    expect(client).to receive(:get).with(endpoint)

    subject
  end

  it "returns the body of the response" do
    expect(subject).to eq response_body
  end
end

RSpec.shared_examples "a get request with params" do |endpoint|
  include_context "with metrc client"

  it "returns the body of the response" do
    expect(subject).to eq response_body
  end

  it "calls #{endpoint} with params" do
    expect(client).to receive(:get).with(endpoint, params)

    subject
  end
end
