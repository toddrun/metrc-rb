class Metrc
  class Labtests
    def self.states(client: nil)
      new(client).states
    end

    def self.types(client: nil)
      new(client).types
    end

    def self.results(client: nil, package_id: nil)
      new(client).results(package_id)
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

    def results(package_id = nil)
      return client.get("/labtests/v1/results") if package_id.nil?

      client.get("/labtests/v1/results", { package_id: package_id} )
    end
  end
end
