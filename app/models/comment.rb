# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  comment    :string(255)
#  user_id    :integer
#  story_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :comment, :story_id, :user_id

  belongs_to :user
  belongs_to :story

  validates :comment, :presence => true
end
