class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |u|
      u.provider = auth.provider
      u.uid = auth.uid
      u.name = auth.info.name
      u.email = auth.info.email
      u.oauth_token = auth.credentials.token
      u.oauth_refresh_token = auth.credentials.refresh_token
      u.oauth_expires_at = Time.at(auth.credentials.expires_at)
      u.save!
    end
  end
end
