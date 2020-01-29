# frozen_string_literal: true

module FSecretLoader
  # Configuration Class
  class Configuration
    attr_accessor :secret_client, :secret_id

    def initialize
      set_default_values
    end

    def secret_client
      @secret_client || default_client
    end

    private

    def set_default_values
      @secret_id             = ENV['AWS_SECRETS_MANAGER_ID']
      @secret_manager_client = nil
    end

    def default_client
      Aws::SecretsManager::Client.new
    end
  end
end
