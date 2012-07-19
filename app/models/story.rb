class Story < ActiveRecord::Base
  attr_accessible :description, :story_type, :project_id

  belongs_to :project
  belongs_to :user

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

end
