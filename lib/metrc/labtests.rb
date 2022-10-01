class Metrc
  class Labtests
    def self.states(client: nil)
      new(client).states
    end

    def self.types(client: nil)
      new(client).types
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
  end
end
