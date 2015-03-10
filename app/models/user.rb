class User < ActiveRecord::Base
  def self.from_omniauth!(auth)
    user = User.where({
      provider: auth.provider,
      uid: auth.uid,
    }).first
    user ||= User.new({
      provider: auth.provider,
      uid: auth.uid,
      given_name: auth.info.first_name,
      surname: auth.info.last_name,
      email: auth.info.email,
    })
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.save!
    user
  end

  def full_name
    [given_name, surname].join(" ").strip
  end

  def gravatar_url(size = 200)
    hash = Digest::MD5.hexdigest(email)
    query_parameters = {
      d: 'mm', #facebook like default image
      s: size,
    }
    "https://secure.gravatar.com/avatar/#{hash}?#{query_parameters.to_param}"
  end
end
