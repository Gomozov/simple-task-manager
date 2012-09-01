# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  admin           :boolean
#  avatar          :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :avatar
  mount_uploader :avatar, AvatarUploader

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
  has_many :comments
  
  default_scope :order => 'users.id'

  def get_responsibles
    Story.find_all_by_responsible(self.id)
  end
  
end
