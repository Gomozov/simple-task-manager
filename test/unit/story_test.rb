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

require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
