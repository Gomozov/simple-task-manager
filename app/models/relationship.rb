class Relationship < ActiveRecord::Base
  attr_accessible :work_id, :member_id

  belongs_to :member, :class_name => "User"
  belongs_to :work, :class_name => "Project"

  validates :work_id, :presence => true
  validates :member_id, :presence => true
end
