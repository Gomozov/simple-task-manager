class Project < ActiveRecord::Base
  attr_accessible :description, :title, :public
  belongs_to :user
  has_many :stories, :dependent => :destroy


  validates :title, :presence => true, :length => { :maximum => 80 }
  validates :user_id, :presence => true
  
  default_scope :order => 'projects.created_at'
end
