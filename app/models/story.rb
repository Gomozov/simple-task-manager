# == Schema Information
#
# Table name: stories
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :integer
#  state       :string(255)
#  story_type  :string(255)
#  responsible :integer
#

class Story < ActiveRecord::Base
  attr_accessible :description, :story_type, :project_id, :responsible

  belongs_to :project
  belongs_to :user
  has_many :comments

  validates :description, :presence => true, :length => { :maximum => 80 }
  validates :project_id, :presence => true
  validates :story_type, :presence => true

  state_machine :state, :initial => :not_yet_started do
    event :start do
      transition :not_yet_started => :started
    end

    event :deliver do
      transition :started => :delivered
    end

    event :accept do
      transition :delivered => :accepted
    end

    event :reject do
      transition :delivered => :rejected
    end

    event :finish do
      transition :accepted => :finished
    end

    event :restart do
      transition :rejected => :started
    end
  end

def get_responsible
    User.find_by_id(self.responsible)
end

end
