class Comment < ActiveRecord::Base
  attr_accessible :comment, :story_id, :user_id

  belongs_to :user
  belongs_to :story

  validates :comment,  :presence => true, :length   => { :maximum => 50 }
end
