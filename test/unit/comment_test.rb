# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  comment    :string(255)
#  user_id    :integer
#  story_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
