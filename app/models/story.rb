class Story < ActiveRecord::Base
  attr_accessible :description, :type

  belongs_to :project
end
