class Question < ActiveRecord::Base
  belongs_to :user
  has_many :likes

  validates :user,
    :presence => true

  validates :description,
    :presence => true,
    :length => { :maximum => 140 } 

  acts_as_taggable

  before_save :downcase_tags

  private
  
  def downcase_tags
    self.tag_list = self.tag_list.map(&:downcase)
  end
end
