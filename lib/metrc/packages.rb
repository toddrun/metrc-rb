class Metrc
  class Packages
    def self.types(client: nil)
      new(client).types
    end

    def self.get(package_id:, client: nil)
      new(client).get(package_id)
    end

    def self.active(days_ago_start: nil, days_ago_end: nil, client: nil)
      new(client).active(days_ago_start, days_ago_end)
    end

    attr_reader :client

    def initialize(client = nil)
      @client = client || Metrc::Client.new
    end

    # active - gets packages based on the last time they were modified.
    # With no arguments, only packages modified during today are returned.
    # With only days_ago_start, packages modified going back that many days,
    # and any modified today, are returned. With both days_ago_start and
    # days_ago_end, packages modified going back to days_ago_start, until
    # days_ago_end are returned.
    def active(days_ago_start = nil, days_ago_end = nil)
      raise NoStartDateException if days_ago_start.nil? && !days_ago_end.nil?

      if days_ago_start.nil?
        return client.get("/packages/v1/active")
      end

      current_date = days_ago_start
      end_date  = days_ago_end || 0
      params = {}
      results = []

      while current_date > end_date
        params[:lastModifiedStart] = date_calculator.days_ago(current_date)
        params[:lastModifiedEnd] = date_calculator.days_ago(current_date - 1)

        results = results + client.get("/packages/v1/active", params)
        current_date -= 1
      end

      if end_date == 0
        results = results + (client.get("/packages/v1/active"))
      end

      results
    end

    def get(package_id)
      client.get("/packages/v1/#{package_id}")
    end

    def types
      client.get("/packages/v1/types")
    end

    def date_calculator
      @date_calculator ||= DateCalculator.new
    end
  end
end
