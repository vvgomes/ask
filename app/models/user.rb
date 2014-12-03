class User < ActiveRecord::Base
  validates :email,
    :presence => true,
#    :email => true,
    :uniqueness => true

  def self.from_omniauth(auth)
    email = auth[:uid]
    where(:email => email).first_or_initialize.tap do |user|
      user.email = email
      user.save!
    end
  end
end
