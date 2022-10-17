class Metrc
  class Labtests
    def self.states(client: nil)
      new(client).states
    end

    def self.types(client: nil)
      new(client).types
    end

    def self.results(package_id:, client: nil)
      new(client).results(package_id)
    end

    def self.record(body: , client: nil)
      new(client).record(body)
    end

    def self.labtestdocument(
      lab_test_result_id:,
      file_name:,
      encoded_file:,
      client: nil
    )
      new(client).labtestdocument(lab_test_result_id, file_name, encoded_file)
    end

    attr_reader :client

    def initialize(client = nil)
      @client = client || Metrc::Client.new
    end

    def states
      client.get("/labtests/v1/states")
    end

    def types
      client.get("/labtests/v1/types")
    end

    def results(package_id)
      client.get("/labtests/v1/results", { packageId: package_id} )
    end

    def record(body)
      client.post("/labtests/v1/record", body)
    end

    def labtestdocument(lab_test_result_id, file_name, encoded_file)
      body = {
        LabTestResultId: lab_test_result_id,
        DocumentFileName: file_name,
        DocumentFileBase64: encoded_file
      }

      client.put("/labtests/v1/labtestdocument", body)
    end
  end
end
