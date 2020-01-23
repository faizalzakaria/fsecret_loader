# FSecretLoader

FSecretLoader to load the AWS Secret Manager and set the key pair to ENV.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fsecret_loader'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fsecret_loader

## Usage

You might want to load the secret as early as possible.

Ex, in Rails app,

```ruby
## config/application.rb

FSecretLoader.config do
  secret_client = Aws::SecretsManager::Client.new(profile: code3, region: 'ap-southeast-1')
  secret_id = 'staging/Api/Env'
end
FSecretLoader.load
```

For more details for aws secret manager config, you can refer [here](https://docs.aws.amazon.com/sdkforruby/api/Aws/SecretsManager/Client.html).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
