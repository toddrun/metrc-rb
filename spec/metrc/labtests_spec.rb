# frozen_string_literal: true

require "spec_helper"

RSpec.describe Metrc::Labtests do
  let(:response_body) { "some response" }
  let(:response_status) { 200 }
  let(:client) do
    instance_double(
      Metrc::Client,
      get: response_body,
      post: response_status,
      put: response_status
    )
  end

  describe "states" do
    subject { Metrc::Labtests.states(client: client) }

    it_behaves_like "a simple get request", "/labtests/v1/states"
  end

  describe "types" do
    subject { Metrc::Labtests.types(client: client) }

    it_behaves_like "a simple get request", "/labtests/v1/types"
  end

  describe "results" do
    subject { Metrc::Labtests.results(client: client, package_id: package_id) }

    let(:package_id) { 'some-package-id' }
    let(:params) { { packageId: package_id } }

    it_behaves_like "a get request with params", "/labtests/v1/results"
  end

  describe "record" do
    subject { Metrc::Labtests.record(client: client, body: body) }

    let(:package_id) { 'some-package-id' }
    let(:body) { { packageId: package_id } }

    it_behaves_like "a post request", "/labtests/v1/record"
  end

  describe "labtestdocument" do
    subject do
      Metrc::Labtests.labtestdocument(
        client: client,
        lab_test_result_id: lab_test_result_id,
        file_name: file_name,
        encoded_file: encoded_file
      )
    end

    let(:lab_test_result_id) { 17 }
    let(:file_name) { "cat1.jpeg" }
    let(:file_data) { File.open("spec/fixtures/#{file_name}").read }
    let(:encoded_file) { Base64.strict_encode64(file_data) }
    let(:body) do
      {
        LabTestResultId: lab_test_result_id,
        DocumentFileName: file_name,
        DocumentFileBase64: encoded_file
      }
    end

    it_behaves_like "a put request", "/labtests/v1/labtestdocument"
  end
end
