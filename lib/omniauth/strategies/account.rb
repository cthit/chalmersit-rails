module OmniAuth
  module Strategies
    class Account < OmniAuth::Strategies::OAuth2
      option :name, :account

      option :client_options, {
        site: Rails.configuration.account_ip,
        authorize_path: '/oauth/authorize'
      }

      uid do
        raw_info['uid']
      end

      info do
        { name: raw_info["display_name"] }
      end

      def raw_info
        @raw_info ||= access_token.get('/me.json').parsed
      end
    end
  end
end
