# == Schema Information
#
# Table name: relationships
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  member_id  :integer
#  work_id    :integer
#

class Relationship < ActiveRecord::Base
  attr_accessible :work_id, :member_id

  belongs_to :member, :class_name => "User"
  belongs_to :work, :class_name => "Project"

  validates :work_id, :presence => true
  validates :member_id, :presence => true
end
