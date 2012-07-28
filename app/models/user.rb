class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }
  validates :email, :presence => true,
                    :uniqueness => true

  has_secure_password

  validates_presence_of :password

  has_many :projects, :dependent => :destroy
  has_many :stories, :dependent => :destroy

  has_many :reverse_relationships, :foreign_key => "member_id", :class_name => "Relationship", :dependent => :destroy
  has_many :works, :through => :reverse_relationships, :source => :work

end
