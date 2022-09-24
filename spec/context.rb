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

RSpec.shared_examples "a get request with param" do |endpoint, param_name, param_value|
  include_context "with metrc client"

  let(:query) do
    obj = {}
    obj[param_name] = param_value
    { query: obj } 
  end

  let(:client) { Metrc::Client.new }

  it_behaves_like "a simple get request", endpoint

  it "includes '#{param_name}' with value of '#{param_value}'" do
    stubbed_request = stub_request(:get, endpoint)
      .with(query)
      .to_return(body: response_body)
    subject

    assert_requested(stubbed_request)
  end

end
