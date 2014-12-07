class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates :user,
    :presence => true,
    :uniqueness => { :scope => :question_id }

  validates :question,
    :presence => true,
    :uniqueness => { :scope => :user_id }
end
