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

end
