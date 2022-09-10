# frozen_string_literal: true

require "faraday"
require "base64"

class Metrc
  class Client

    attr_reader :domain, :license_number, :user_key, :vendor_key

    def initialize(config = Config.new)
      @domain = config.domain
      @license_number = config.license_number
      @user_key = config.user_key
      @vendor_key = config.vendor_key
    end

    def get(base, params = {})
      client.get(build_url(base), build_params(params), headers)
    end

    private

    def build_url(path)
      domain + path
    end

    def build_params(params)
      params.merge(licenseNumber: license_number)
    end

    def headers
      @headers ||= {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Basic " + auth_header
      }
    end

    def auth_header
      @auth_header ||= Base64.strict_encode64("#{user_key}:#{vendor_key}")
    end

    def client
      Faraday.new(domain)
    end
  end
end
