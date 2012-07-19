class AddStateToStory < ActiveRecord::Migration
  def change
    add_column :stories, :state, :string, :defoult => "not_yet_started"
  end
end
