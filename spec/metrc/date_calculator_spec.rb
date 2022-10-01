# frozen_string_literal: true

require "spec_helper"

RSpec.describe Metrc::DateCalculator do
  subject(:calculator) { Metrc::DateCalculator.new }

  let(:today) { Time.now }
  let(:day_in_seconds) { 60 * 60 * 24 }
  let(:expected_portion) { "#{expected_date.day}T00:00:00Z" }

  context "without non-positive integer argument" do
    let(:expected_date) { today }

    it "returns today" do
      [nil, 0, -12, "foobar"].each do |val|
        expect(calculator.days_ago(val)).to include expected_portion
      end
    end
  end

  context "with a one" do
    let(:expected_date) { today - day_in_seconds }

    it "returns yesterday" do
      expect(calculator.days_ago(1)).to include expected_portion
    end
  end

  context "with a positive integer argument" do
    let(:expected_date) { today - (day_in_seconds * 3) }

    it "returns expected values" do
      expect(calculator.days_ago(3)).to include expected_portion
    end
  end
end
