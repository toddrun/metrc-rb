# frozen_string_literal: true

require "spec_helper"

RSpec.describe Metrc::Packages do
  let(:response_body) { "some response" }
  let(:package_id) { "abc-123-xyz-987" }

  describe "active" do
    subject do
      Metrc::Packages.active(
        client: client,
        days_ago_start: days_ago_start,
        days_ago_end: days_ago_end
      )
    end

    include_context "with metrc client"
    let(:response_body) { [ { Id: 4, Label: "abc-123" } ] }

    def pad(num)
      return num if num >= 10

      "0#{num}"
    end

    def format_output(days_ago)
      return nil if days_ago.nil?

      time = Time.new - (days_ago * 60 * 60 * 24)
      "#{time.year}-#{pad(time.month)}-#{pad(time.day)}T00:00:00Z"
    end

    let(:days_ago_start) { nil }
    let(:days_ago_end) { nil }
    let(:expected_start_date) do
      format_output(days_ago_start)
    end
    let(:expected_end_date) do
      format_output(days_ago_end)
    end

    context "without arguments" do
      it_behaves_like "a simple get request", "/packages/v1/active"
    end

    context "with 'days_ago_start' argument" do
      let(:days_ago_start) { 3 }
      let(:start_dates) do
        [ format_output(3), format_output(2), format_output(1), format_output(0) ]
      end

      let(:params) { { lastModifiedStart: format_output(days_ago_start) } }

      it 'gets records for each day' do
        expect(client).to receive(:get).with("/packages/v1/active")
        start_dates.each_with_index do |date, index|
          if index + 1 < start_dates.length
            current_date = start_dates[index]
            next_date = start_dates[index + 1]

            expect(client).to receive(:get).with(
              "/packages/v1/active",
              {
                lastModifiedStart: current_date,
                lastModifiedEnd: next_date
              }
            )
          end
        end

        subject
      end
    end

    context "with only 'days_ago_end' argument" do
      let(:days_ago_end) { 3 }

      it 'raise an error' do
        expect { subject }.to raise_error(Metrc::NoStartDateException)
      end
    end
  end

  describe "get" do
    subject { Metrc::Packages.get(package_id: package_id, client: client) }

    it_behaves_like "a simple get request", "/packages/v1/abc-123-xyz-987"
  end

  describe "types" do
    subject { Metrc::Packages.types(client: client) }

    it_behaves_like "a simple get request", "/packages/v1/types"
  end
end
