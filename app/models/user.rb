class User < ActiveRecord::Base

  has_many :branches
  has_many :messages
  
  def self.from_omniauth(auth)
    where(provider: auth['provider'], uid: auth['uid']).first_or_create do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.nickname = auth['info']['nickname']
        user.email = auth['info']['email']
        user.name = auth['info']['name']
        user.first_name = auth['info']['first_name']
        user.last_name = auth['info']['last_name']
        user.image = auth['info']['image']
        user.location = auth['info']['location']
      end
      if auth['credentials'] 
        user.oauth_token = auth['credentials']['token']
        user.oauth_expires_at = Time.at(auth['credentials']['expires_at']) if auth['credentials']['expires_at']
      end
      user.save!
    end
  end

end