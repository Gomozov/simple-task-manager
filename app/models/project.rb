class Project < ActiveRecord::Base
  attr_accessible :description, :title, :public
  belongs_to :user
  has_many :stories, :dependent => :destroy
  has_many :relationships, :foreign_key => "work_id", :dependent => :destroy
  has_many :members, :through => :relationships, :source => :member

  validates :title, :presence => true, :length => { :maximum => 80 }
  validates :user_id, :presence => true
  validates :description, :presence => true
  
  default_scope :order => 'projects.created_at'

  def member? (member)
    relationships.find_by_member_id(member)
  end

  def member! (member)
    relationships.create!(:member_id => member.id)
  end

  def unmember! (member)
    relationships.find_by_member_id(member).destroy
  end

  def user_responsible (user)
    Story.find(:all, :conditions => {:project_id => self.id, :responsible => user.id})
  end

end
