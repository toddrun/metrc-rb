# frozen_string_literal: true

class Metrc
  class DateCalculator
    attr_reader :current

    SECONDS_IN_A_DAY = 60 * 60 * 24;

    def initialize
      @current = Time.now
    end

    def days_ago(number)
      offset = SECONDS_IN_A_DAY * positive(number)
      output(current - offset)
    end

    private

    def positive(number)
      return 0 unless number && number.is_a?(Integer) && number > 0

      number
    end

    def output(time)
      "#{date_portion(time)}T00:00:00Z"
    end

    def date_portion(time)
      time.strftime("%Y-%m-%d")
    end
  end
end
