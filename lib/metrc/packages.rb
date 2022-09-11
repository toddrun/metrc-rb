class Metrc
  class Packages
    def self.types(metrc_client = nil)
      new(metrc_client).types
    end

    attr_reader :metrc_client

    def initialize(metrc_client = nil)
      @metrc_client = metrc_client || Metrc::Client.new
    end

    def types
      metrc_client.get("/packages/v1/types")
    end
  end
end
