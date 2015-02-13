class User < ActiveRecord::Base


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['name'] if auth['info']
      if auth['credentials'] 
        user.oauth_token = auth['credentials']['token']
        user.oauth_expires_at = Time.at(auth['credentials']['expires_at']) if auth['credentials']['expires_at']
      end
      user.save!
    end
  end
  
  def self.create_with_omniauth(auth)
    
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

end