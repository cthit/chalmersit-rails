class Session < ActiveRecord::Base
  belongs_to :user

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |session|
      session.provider = auth.provider
      session.uid = auth.uid
      session.token = auth.credentials.token
    end
  end
end
