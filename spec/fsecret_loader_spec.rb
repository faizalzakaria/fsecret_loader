# frozen_string_literal: true

RSpec.describe FsecretLoader do
  let(:secret_client) { Aws::SecretsManager::Client.new }
  let(:secret_id) { 'staging/Api/Test' }
  let(:sample_secret_response) do
    OpenStruct.new(secret_string: "{\n  \"username\":\"david\",\n  \"password\":\"123\"\n}\n")
  end

  describe 'config' do
    it 'sets config values' do
      FSecretLoader.config do |config|
        config.secret_client = secret_client
        config.secret_id = secret_id
      end

      expect(FSecretLoader.configuration.secret_client).to eq(secret_client)
      expect(FSecretLoader.configuration.secret_id).to eq(secret_id)
    end
  end

  describe 'load' do
    subject { FSecretLoader.load }

    before do
      FSecretLoader.config do |config|
        config.secret_client = secret_client
        config.secret_id = secret_id
      end
      allow(secret_client).to receive(:get_secret_value).with(secret_id: secret_id).and_return(sample_secret_response)
      FSecretLoader.load
    end

    it 'sets the ENV correctly' do
      aggregate_failures do
        expect(ENV['username']).to eql('david')
        expect(ENV['password']).to eql('123')
      end
    end
  end
end
