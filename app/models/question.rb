class Question < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  validates :user, :presence => true
  validates :description, :presence => true
end
