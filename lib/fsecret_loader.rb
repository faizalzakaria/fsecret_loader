# frozen_string_literal: true

require 'aws-sdk-secretsmanager'
require 'json'
require 'fsecret_loader/version'
require 'fsecret_loader/configuration'

# FSecretLoader module
module FSecretLoader
  class << self
    def config
      yield configuration
    end

    def load
      secrets.each_pair do |key, value|
        ENV[key.to_s] = value.to_s
      end
    end

    def configuration
      @configuration ||= Configuration.new
    end

    private

    def secrets
      JSON.parse(
        configuration
          .secret_client
          .get_secret_value(secret_id: configuration.secret_id)
          .secret_string
      )
    end
  end
end
