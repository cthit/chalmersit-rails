class User < ActiveRestClient::Base
  extend ActiveModel::Naming
  base_url Rails.configuration.account_ip

  before_request :set_bearer

  if Rails.env.test?
    get :all, '/users', fake: [{uid: 'smurf'}, {uid: 'smurf2'}]
    get :find, '/users/:id', fake: [{uid: 'smurf', display_name: 'Smurre smurf Smurfen'}]
  else
    get :all, '/users'
    get :find, '/users/:id'
  end

  def posts
    @posts ||= Post.find_by(user_id: uid)
  end

  private

    def set_bearer(name, request)
      request.headers['authorization'] = "Bearer #{Rails.application.secrets.client_credentials}"
    end
end
