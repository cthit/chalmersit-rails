class User < ActiveRestClient::Base
  base_url Rails.configuration.account_ip

  before_request :set_bearer

  get :all, "/users"
  get :find, "/users/:id"

  def posts
    @posts ||= Post.find_by(user_id: uid)
  end

  private

    def set_bearer(name, request)
      request.headers['authorization'] = "Bearer #{Rails.application.secrets.client_credentials}"
    end
end
