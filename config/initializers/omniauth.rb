require File.expand_path('lib/omniauth/strategies/account', Rails.root)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :account, ENV["OAUTH_ID"], ENV["OAUTH_SECRET"], provider_ignores_state: true
  provider :developer
end

account = OmniAuth::Strategies::Account.new :account, ENV["OAUTH_ID"], ENV["OAUTH_SECRET"]

AccessToken = account.token
