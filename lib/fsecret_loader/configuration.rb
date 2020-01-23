# frozen_string_literal: true

module FSecretLoader
  # Configuration Class
  class Configuration
    attr_accessor :secret_client, :secret_id

    def initialize
      set_default_values
    end

    private

    def set_default_values
      @secret_manager_client = Aws::SecretsManager::Client.new
      @secret_id             = 'test'
    end
  end
end
