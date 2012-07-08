class Project < ActiveRecord::Base
  attr_accessible :description, :title
  belongs_to :user

  validates :title, :presence => true, :length => { :maximum => 80 }
  validates :user_id, :presence => true
  
  default_scope :order => 'projects.created_at DESC'
end
