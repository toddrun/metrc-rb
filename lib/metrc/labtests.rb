class Metrc
  class Labtests
    def self.states(metrc_client = nil)
      new(metrc_client).states
    end

    def self.types(metrc_client = nil)
      new(metrc_client).types
    end

    attr_reader :metrc_client

    def initialize(metrc_client = nil)
      @metrc_client = metrc_client || Metrc::Client.new
    end

    def states
      metrc_client.get("/labtests/v1/states")
    end

    def types
      metrc_client.get("/labtests/v1/types")
    end
  end
end
