class Metrc
  class Config
    def domain
      ENV['METRC_DOMAIN']
    end

    def license_number
      ENV['METRC_LICENSE']
    end

    def user_key
      ENV['METRC_USER_KEY']
    end

    def vendor_key
      ENV['METRC_VENDOR_KEY']
    end
  end
end
