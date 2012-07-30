class AddResponsibleToStory < ActiveRecord::Migration
  def change
    add_column :stories, :responsible, :integer
  end
end
