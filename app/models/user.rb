class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  def generate_referral_token
    SecureRandom.urlsafe_base64(32)
  end
end
