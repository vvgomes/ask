class User < ActiveRecord::Base
  has_many :questions, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  has_many :favorites, :through => :likes, :source => :question

  validates :email,
    :presence => true,
    :email => true,
    :uniqueness => true,
    :format => /@thoughtworks\.com/

  def self.from_omniauth(auth)
    email = auth[:extra][:raw_info][:email]
    where(:email => email).first_or_initialize.tap do |user|
      user.email = email
      user.save!
    end
  end

  def username
    email.split('@').first
  end

  def likes?(question)
    likes.where(:question => question).exists?
  end
end
